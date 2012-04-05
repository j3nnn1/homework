use strict;
use warnings;

use rest;

my $app = rest->apply_default_middlewares(rest->psgi_app);
$app;

