use strict;
use File::Basename 'dirname';
use File::Copy 'copy', 'move';

my $program = 'generate-vf';

my $temp = '__jdgv' . $$;
my $jfmutil = 'jfmutil';

my @shape = (
  [qw(minl   ml )],
  [qw(minr   mr )],
  [qw(minb   mb )],
  [qw(gothr  gr )],
  [qw(gothb  gb )],
  [qw(gotheb ge )],
  [qw(mgothe mgr)],
);

my @zvpname = qw(
jodhminl-hq
zu-jodhminl-hq
jodhminln-h
jodhminln-v
);

sub error {
  print STDERR (join(": ", $program, @_), "\n");
  exit(1);
}
sub run {
  local $_ = system(@_);
  my $s = $_ >> 8;
  ($_ == 0) or error("command failure (status=$s)", "@_");
}

{
  local $_ = `jfmutil --help`;
  (m/jfmutil/) or error("jfmutil is not installed");
  my $base = dirname($0);
  my $dzvp = "$base/../zvp";
  (-d $dzvp) or error("not found", $dzvp);

  mkdir($temp) or error("cannot make directory", $temp);
  foreach (map { "$_.zvp" } (@zvpname)) {
    copy("$dzvp/$_", "$temp/$_")
      or error("copy failure", "$dzvp/$_");
  }
  
  chdir($temp);
  # first
  foreach (@zvpname) {
    run("$jfmutil zvp2vf $_");
  }
  # following
  foreach (1 .. $#shape) {
    my ($shl, $shs) = @{$shape[$_]};
    my ($sovf, $suvf, $snhvf, $snvvf) = @zvpname;
    my ($dovf, $duvf, $dnhvf, $dnvvf) = 
        map { s/minl/$shl/;$_ } (@{[@zvpname]});
    run("$jfmutil vfcopy $sovf  $dovf  otf-cj$shs-h");
    run("$jfmutil vfcopy $suvf  $duvf  otf-uj$shs-h");
    run("$jfmutil vfcopy $snhvf $dnhvf h${shl}n-h otf-cj$shs-h");
    run("$jfmutil vfcopy $snvvf $dnvvf h${shl}n-v otf-cj$shs-v");
    unlink("otf-cj$shs-h.tfm", "otf-cj$shs-v.tfm", "otf-uj$shs-h.tfm");
    unlink("h${shl}n-h.tfm", "h${shl}n-v.tfm");
  }
  foreach (glob('*.tfm'), glob('*.vf')) {
    move("$_", "../$_");
  }
  unlink(glob('*.zvp'));
  chdir("..");

  rmdir($temp) or error("cannot remove directory", $temp);
}
