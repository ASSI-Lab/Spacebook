FactoryBot.define do
    factory :temp_dep do
        user_id             {1}
        name                {'Test department'}
        manager             {'test.manager@gmail.com'}
        via                 {'Via eudossiana'}
        civico              {'8'}
        cap                 {'00185'}
        citta               {'Roma'}
        provincia           {'RM'}
        lat                 {'41.8932591'}
        lon                 {'12.4930178'}
        dep_map             {nil}
        dep_event           {nil}
        description         {'dipartimento test'}
        floors              {1}
        number_of_spaces    {2}
        created_at          {Time.now}
        updated_at          {Time.now}
    end
end