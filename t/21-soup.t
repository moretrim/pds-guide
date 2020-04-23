=begin COPYRIGHT
Copyright © 2019 moretrim.

This file is part of the test suite for pds-companion.

To the extent possible under law, the author has waived all copyright
and related or neighboring rights to this file. This work is published
from France.

A copy of of the CC0 1.0 Universal license is also provided. If not,
see L<https://creativecommons.org/publicdomain/zero/1.0/>.
=end COPYRIGHT

use Test;
use lib 'lib';

use PDS;

my PDS::Grammar \test-grammar = PDS::Unstructured.new(source => $?FILE);

use lib 't';
use resources::vic2-model-event00;

my \expectations = [
    country_event => [
        id => 45100,

        trigger => [
            tag => 'HAI',
            year => 1860,
            exists => 'PAP',
            NOT => [year => 1863],
        ],

        :fire_only_once,

        mean_time_to_happen => [
            months => 5,
            modifier => [
                factor => 0.75,
                year => 1861,
            ],

            modifier => [
                factor => 0.95,
                year => 1862,
            ],
        ],

        title => '"EVTNAME45100"',
        desc => '"EVTDESC45100"',
        picture => '"pope"',

        option => [
            name => '"EVTOPTA45100"',

            prestige => 5,

            relation => [
                who => 'PAP',
                value => 50,
            ],

            any_pop => [
                limit => [
                    :is_state_religion,
                ],

                scaled_militancy => [
                    factor => -3,
                    issue => 'moralism',
                ],
            ],
        ],
    ],

    country_event => [
        id => 45101,
        title => '"EVTNAME45101"',
        desc => '"EVTDESC45101"',
        picture => '"monarchy"',

        trigger => [
            tag => 'HAI',
            year => 1847,
            government => 'democracy',
            NOT => [ year => 1859 ],
        ],

        :fire_only_once,

        mean_time_to_happen => [
            months => 6,
        ],

        option => [
            name => '"EVTOPTA45101"',

            government => 'absolute_monarchy',
            ruling_party_ideology => 'reactionary',

            political_reform => 'none_voting',
            political_reform => 'party_appointed',
            political_reform => 'no_meeting',
            political_reform => 'state_press',
            political_reform => 'state_controlled',
            political_reform => 'underground_parties',

            clr_country_flag => 'election_started',
            clr_country_flag => 'conservative_party_in_power',
            clr_country_flag => 'liberal_party_in_power',
            clr_country_flag => 'reactionary_party_in_power',
            clr_country_flag => 'socialist_party_in_power',
            clr_country_flag => 'communist_party_in_power',
            clr_country_flag => 'fascist_party_in_power',
            clr_country_flag => 'anarcho_liberal_party_in_power',

            prestige => -5,
            country_event => 800050,
        ],
    ],

    country_event => [
        id => 45102,
        title => '"EVTNAME45102"',
        desc => '"EVTDESC45102"',
        picture => '"la_trinitaria"',

        trigger => [
            tag => 'HAI',
            year => 1838,
            owns => 2214,
            owns => 2216,
            NOT => [ exists => 'DOM' ],
        ],

        :fire_only_once,

        mean_time_to_happen => [
            months => 6,
        ],

        option => [
            name => '"EVT45102OPTA"',

            any_pop => [
                limit => [
                    location => [ is_core => 'DOM' ],
                    has_pop_culture => 'caribeno',
                ],

                militancy => 5,
                consciousness => 5,
            ],

            any_owned => [
                limit => [ is_core => 'DOM' ],

                add_province_modifier => [
                    name => 'nationalist_agitation',
                    duration => 2190,
                ],
            ],
        ],
    ],

    country_event => [
        id => 45103,
        title => '"EVTNAME45103"',
        desc => '"EVTDESC45103"',
        picture => '"dominican_revolution"',

        :fire_only_once,

        trigger => [
            tag => 'DOM',
            :exists,
            2214 => [ is_core => 'HAI', owned_by => 'THIS', ],
            2216 => [ is_core => 'HAI', owned_by => 'THIS', ],
            :!war,
            NOT => [ truce_with => 'HAI', ],
        ],

        mean_time_to_happen => [ months => 60, ],

        option => [
            name => '"EVT45103OPTA"',

            remove_accepted_culture => 'afro_caribeno',

            add_casus_belli => [
                target => 'HAI',
                type => 'conquest',
                months => 24,
            ],

            relation => [
                who => 'HAI',
                value => -25,
            ],

            any_owned => [
                limit => [ is_core => 'DOM', ],

                remove_core => 'HAI',
                remove_province_modifier => 'nationalist_agitation',

                any_pop => [
                    militancy => -9,
                    consciousness => -9,
                ],
            ],
        ],
    ],

    country_event => [
        id => 45104,
        title => '"EVTNAME45104"',
        desc => '"EVTDESC45104"',
        picture => '"dominican_revolution"',

        :fire_only_once,

        trigger => [
            tag => 'HAI',
            owns => 2214,
            owns => 2216,
            :exists,
            2214 => [ is_core => 'HAI', ],
            2216 => [ is_core => 'HAI', ],
            year => 1844,
            any_owned_province => [ is_core => 'DOM', average_militancy => 6, ],
            NOT => [ year => 1870, ],
        ],

        mean_time_to_happen => [ months => 8, ],

        option => [
            name => '"EVT45104OPTA"',

            remove_accepted_culture => 'caribeno',
            remove_accepted_culture => 'afro_caribeno',	

            any_owned => [
                limit => [ is_core => 'DOM', ],

                any_pop => [ militancy => -9, consciousness => -9, ],
                remove_province_modifier => 'nationalist_agitation',
                secede_province => 'DOM',
            ],

            'DOM' => [
                define_general => [
                    name => '"Pedro Santana"',
                    personality => 'implacable',
                    background => 'nationalist',
                ],

                add_country_modifier => [
                    name => 'unrecognized_country', duration => 3650,
                ],
            ],

            relation => [ who => 'DOM', value => -400, ],

            war => [
                target => 'DOM',
                attacker_goal => [ casus_belli => 'conquest', ],
                defender_goal => [ casus_belli => 'status_quo', ],
            ],

            ai_chance => [ factor => 100, ],
        ],

        option => [
            name => '"EVT45104OPTB"',

            remove_accepted_culture => 'caribeno',
            remove_accepted_culture => 'afro_caribeno',

            any_owned => [
                limit => [ is_core => 'DOM', ],

                any_pop => [ militancy => -9, consciousness => -9, ],
                remove_province_modifier => 'nationalist_agitation',
                secede_province => 'DOM',
            ],

            DOM => [
                define_general => [
                    name => '"Pedro Santana"',
                    personality => 'implacable', background => 'nationalist',
                ],

                add_accepted_culture => 'afro_caribeno',
            ],

            relation => [ who => 'DOM', value => -400, ],

            war => [
                target => 'DOM',
                attacker_goal => [ casus_belli => 'conquest', ],
                defender_goal => [ casus_belli => 'status_quo', ],
            ],

            change_tag_no_core_switch => 'DOM',

            ai_chance => [ factor => 0, ],
        ],
    ],

    country_event => [
        id => 45105,
        title => '"EVTNAME45105"',
        desc => '"EVTDESC45105"',
        picture => '"annexation_santo_domingo"',

        :is_triggered_only,

        option => [
            name => '"EVT45105OPTA"',

            FROM => [
                random => [
                    chance => 60,

                    badboy => 5,

                    any_owned => [
                        any_pop => [
                            scaled_militancy => [ factor => 1, ideology => 'conservative', ],
                            scaled_militancy => [ factor => 3, ideology => 'liberal', ],
                            scaled_militancy => [ factor => 3, ideology => 'socialist', ],
                            scaled_militancy => [ factor => 2, issue => 'pacifism', ],
                            scaled_consciousness => [ factor => 4, issue => 'pacifism', ],
                        ],
                    ],

                    any_country => [
                        limit => [ :is_greater_power, ],

                        relation => [ who => 'USA', value => -100, ],
                    ],
                ],
                treasury => -100000,
            ],

            DOM => [ :!civilized, ],
            DOM => [ annex_to => 'FROM', ],
            DOM => [ :civilized, ],

            ai_chance => [
                factor => 0.3,

                modifier => [ factor => 100, vassal_of => 'FROM', ],
                modifier => [ factor => 1.2, NOT => [ literacy => 0.1, ], ],
            ],
        ],

        option => [
            name => '"EVT45105OPTB"',

            FROM => [ diplomatic_influence => [ who => 'THIS', value => -100 ], ],
            relation => [ who => 'FROM', value => -50, ],

            ai_chance => [
                factor => 0.7,

                modifier => [ factor => 0, vassal_of => 'FROM', ],
                modifier => [ factor => 1.5, literacy => 0.3, ],
            ],
        ],
    ],

    country_event => [
        id => 45106,
        title => '"EVTNAME45106"',
        desc => '"EVTDESC45106"',
        picture => '"haiti_debts"',

        :is_triggered_only,

        option => [
            name => '"EVT45106OPTA"',

            prestige => -10,
            set_country_flag => 'agreed_to_pay_debt',

            random_owned => [
                limit => [
                    owner => [
                        NOT => [ money => 500000, ],
                        NOT => [ check_variable => [ which => 'owed_cash_money', value => 1, ], ],
                    ], 
                ],

                owner => [ set_variable => [ which => 'owed_cash_money', value => 500, ], ],
            ],

            random_owned => [
                limit => [
                    owner => [
                        NOT => [ money => 500000, ],
                        check_variable => [ which => 'owed_cash_money', value => 9, ],
                    ], 
                ],

                owner => [ change_variable => [ which => 'owed_cash_money', value => 500, ], ],
            ],

            FRA => [ treasury => 500000, ],

            ai_chance => [
                factor => 90,
            ],
        ],

        option => [
            name => '"EVT45106OPTB"',

            prestige => 10,
            FRA => [ country_event => 45107, ],

            ai_chance => [
                factor => 10,

                modifier => [
                    factor => 3,
                    has_country_modifier => 'malevolent_ai',
                ],
            ],
        ],
    ],

    country_event => [
        id => 45107,
        title => '"EVTNAME45107"',
        desc => '"EVTDESC45107"',
        picture => '"haiti_debts"',

        :is_triggered_only,

        option => [
            name => '"EVT45107OPTA"',

            casus_belli => [
                target => 'FROM',
                type => 'war_reparations',
                months => 12,
            ],

            war => [
                target => 'FROM',
                attacker_goal => [ casus_belli => 'war_reparations', ],
            ],

            ai_chance => [
                factor => 90,
            ],
        ],

        option => [
            name => '"EVT45107OPTB"',

            badboy => 8,
            relation => [ who => 'USA', value => -200, ],

            add_casus_belli => [
                target => 'USA',
                type => 'cut_down_to_size',
                months => 48,
            ],

            casus_belli => [
                target => 'FROM',
                type => 'war_reparations',
                months => 80,
            ],

            casus_belli => [
                target => 'FROM',
                type => 'make_puppet',
                months => 120,
            ],

            war => [
                target => 'FROM',
                attacker_goal => [ casus_belli => 'war_reparations', ],
            ],

            ai_chance => [
                factor => 5,
            ],
        ],

        option => [
            name => '"EVT45107OPTC"',

            badboy => 10,
            relation => [ who => 'USA', value => -300, ],

            add_casus_belli => [
                target => 'USA',
                type => 'cut_down_to_size',
                months => 48,
            ],

            casus_belli => [
                target => 'FROM',
                type => 'conquest',
                months => 12,
            ],

            war => [
                target => 'FROM',
                attacker_goal => [ casus_belli => 'conquest', ],
            ],

            ai_chance => [
                factor => 4,
            ],
        ],

        option => [
            name => '"EVT45107OPTD"',

            badboy => -2,
            prestige => -20,
            relation => [ who => 'HAI', value => 200, ],

            ai_chance => [
                factor => 1,
            ],
        ],
    ],

    country_event => [
        id => 45108,
        title => '"EVTNAME45108"',
        desc => '"EVTDESC45108"',
        picture => '"MEX_pastry_war"',

        :is_triggered_only,

        option => [
            name => '"EVT45108OPTA"',

            random_owned => [
                limit => [
                    owner => [
                        tag => 'HAI',
                        :has_recently_lost_war,
                        truce_with => 'FRA',
                        NOT => [ has_country_flag => 'agreed_to_pay_debt', ],
                    ],
                ],

                owner => [
                    HAI => [
                        set_country_flag => 'agreed_to_pay_debt',
                        set_variable => [ which => 'owed_cash_money', value => 500, ],
                    ],

                    FRA => [ treasury => 500000, ],
                ],
            ],

            random_owned => [
                limit => [
                    owner => [
                        tag => 'MEX',
                        :has_recently_lost_war,
                        truce_with => 'FRA',
                        has_country_flag => 'pay_1st_pastry_war',
                    ],
                ],

                owner => [
                    MEX => [
                        clr_country_flag => 'pay_1st_pastry_war',
                        set_variable => [ which => 'owed_cash_money', value => 80, ],
                    ],

                    FRA => [ treasury => 80000, ],
                ],
            ],
        ],
    ],
];

is-deeply soup(PDS::Unstructured, vic2-model-event00::resource), expectations, "can we parse a representative event file";

subtest "reject malformed inputs", {
    my \script = vic2-model-event00::resource;

    for 1..18 -> \which {
        throws-like
            { soup(test-grammar, script.subst('}', '', nth => which)) },
            X::PDS::ParseError,
            message =>
                / "Error while parsing ‘<string>’ at line 494:" /
                & / "expected closing '}'" /,
            "malformed input was missing closing brace number {which}";
    }

    my \openers = script.comb('{').elems;

    throws-like
        { soup(test-grammar, script.subst('{', '', nth => 1)) },
        X::PDS::ParseError,
        message =>
            / "Error while parsing ‘<string>’ at line 0:" /
            & / "rejected by grammar PDS::Unstructured" /,
        "malformed input was missing opening brace number 1";

    my \locs = 7, 10, 16, 19, 24, 34, 36, 37, 37, 37, 0, 51;
    my &reason = -> \which {
        which != 12 ??
        "expected closing '}'" !!
        "rejected by grammar PDS::Unstructured"
    }
    for 2..* Z locs -> (\which, \loc) {
        throws-like
            { soup(test-grammar, script.subst('{', '', nth => which)) },
            X::PDS::ParseError,
            message =>
                / "Error while parsing ‘<string>’ at line " $(loc) ":" /
                & / $(reason(which)) /,
            "malformed input was missing opening brace number {which}";
    }
}

done-testing;
