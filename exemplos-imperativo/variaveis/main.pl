#https://www.jdoodle.com/execute-perl-online/

sub sub2 {
  $y = $x;
  print "y=".$y."\n";
  print "z=".$z."\n";
}

sub sub1 {
  #local $x = 7; #esta linha redefine x localmente
  $z = 8;
  sub2();
}

$x = 3;

sub1();