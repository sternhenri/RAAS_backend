class CreateUserTable < ActiveRecord::Migration

    def change

    create_table :clients do |t|
      t.string :entity_name, null: false
      t.string :email, null: false
      t.timestamps null: false
      t.string :app_store_url
    end
    add_index :clients, :email, unique: true
  
	 create_table :referrals do |t|
      t.integer :referral_code_id, null: false
      t.integer :converted_user
      t.string :conversion_type
      t.string :ip
      t.boolean :converted, default: false     
      t.timestamps null: false
    end
    add_index :referrals, :ip

    #STI
    #extend for custom codes :D beyond sign up links
  	create_table :referral_codes do |t|

      t.string :code_type
  	  t.string :code
      t.timestamps null: false
      t.integer :client_id, null: false
      t.integer :user_id
    end
    add_index :referral_codes, :client_id

    create_table :referral_settings do |t|
      t.boolean :is_active, default: true
      t.boolean :support_sms, default: true
      t.boolean :support_email, default: true
      t.string :referral_prompt
      t.string :referral_thanks
      t.integer :client_id, null: false
    end

    #####

  end
end
