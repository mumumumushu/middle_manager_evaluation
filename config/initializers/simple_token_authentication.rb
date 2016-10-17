SimpleTokenAuthentication.configure do |config|

  config.sign_in_token = false

  # Configure the name of the HTTP headers watched for authentication.
  #
  # Default header names for a given token authenticatable entity follow the pattern:
    # { entity: { authentication_token: 'X-Entity-Token' } }
  #
  # When several token authenticatable models are defined, custom header names
  # can be specified for none, any, or all of them.
  #
  # Examples
  #
  #   Given User and SuperAdmin are token authenticatable,
  #   When the following configuration is used:
  #     `config.header_names = { super_admin: { authentication_token: 'X-Admin-Auth-Token' } }`
  #   Then the token authentification handler for User watches the following headers:
  #     `X-User-Token, X-User-Email`
  #   And the token authentification handler for SuperAdmin watches the following headers:
  #     `X-Admin-Auth-Token, X-SuperAdmin-Email`
  #
  config.header_names = {
    middle_manager: { authentication_token: 'X-MiddleManager-Token', job_num: 'X-MiddleManager-JobNum' },
    leader: { authentication_token: 'X-Leader-Token', job_num: 'X-Leader-JobNum' },
    staff: { authentication_token: 'X-Staff-Token', job_num: 'X-Staff-JobNum' },
    admin: { authentication_token: 'X-admin-Token', email: 'X-admin-Email' },
  }
  
  config.identifiers = { 
    middle_manager: :job_num, 
    leader: :job_num, 
    staff: :job_num, 
    admin: :email   
  }

end
