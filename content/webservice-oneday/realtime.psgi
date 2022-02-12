use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
use WebServiceOneDay;
use File::Spec;
use Plack::Builder;

my $app = sub {
    my $path = File::Spec->catfile('text.mkdn');
    my $html = WebServiceOneDay::markdown2html($path);
    return [200, [ 'Contet-Type' => 'text/html', 'Content-Length' => length $html ], [$html]];
};

builder {
    enable "Plack::Middleware::Static",
        path => qr{^/(images|js|css|examples|lib)/}, root => './';
    $app;
};
