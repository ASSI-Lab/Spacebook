FactoryBot.define do
    factory :department do
        user_id             {1}
        name                {'Test department'}
        manager             {'test.manager@gmail.com'}
        via                 {'Via eudossiana'}
        civico              {'8'}
        cap                 {'00185'}
        citta               {'Roma'}
        provincia           {'RM'}
        latitude            {'41.8932591'}
        longitude           {'12.4930178'}
        dep_map             {nil}
        dep_event           {nil}
        description         {'dipartimento test'}
        floors              {1}
        number_of_spaces    {2}
        created_at          {Time.now}
        updated_at          {Time.now}
    end
end