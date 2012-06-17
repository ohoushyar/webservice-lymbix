use Test::Most 0.25;

use Lymbix::API;

my $auth_key = 'e3b565ab7ab7450426adc55dc61f08507805e295';
my $accept_type = 'application/json';
my $article_reference_id = '12345';
my $version = '2.2';
my $lymbix;

subtest 'Init' => sub {
    # Minimum requirement init
    $lymbix = Lymbix::API->new(auth_key => $auth_key);
    ok($lymbix, 'Successfully initialized with auth_key and other default values');
    isa_ok($lymbix, 'Lymbix::API');

    # Optional keys
    $lymbix = Lymbix::API->new(
        auth_key => $auth_key,
        accept_type => $accept_type,
        article_reference_id => $article_reference_id,
    );
    ok($lymbix, 'Successfully initialized with optional keys');
    isa_ok($lymbix, 'Lymbix::API');
};

subtest 'Init sanity checks' => sub {
    dies_ok {Lymbix::API->new()} 'Expected to die with no params';
    dies_ok {Lymbix::API->new(auth_key_invalid => $auth_key)} 'Expected to die on invalid parameters';
    dies_ok {Lymbix::API->new(accept_type => $accept_type)} 'Expected to die on missing required params';
    dies_ok {
        Lymbix::API->new(
            accept_type => $accept_type,
            article_reference_id => $article_reference_id
        )} 'Expected to die on missing required params';
    dies_ok {
        Lymbix::API->new(
            auth_key => $auth_key,
            accept_type => 'llll'
        )} 'Expect to die on invalid value for accept_type';
};

done_testing();
