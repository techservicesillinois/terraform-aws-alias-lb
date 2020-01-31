Feature: Test a basic tfvars configuration for the alias-lb module.
    
    
    Scenario: Initialize testing for alias-lb module using private lb.
        
        Given terraform module 'alias-lb'
            | key      | value              |
            #----------|--------------------|
            | hostname | "my-private-alias" |
            | domain   | "local"            |
            | lb_name  | "private2"         |

        When we run terraform plan
        
        Then terraform plans to perform these exact resource actions
            | action | resource           | name       | count |
            #--------|--------------------|------------|-------|
            | create | aws_route53_record | default    |       |

        Then terraform resource 'aws_route53_record' 'default' has changed attributes
            | attr            | value            |
            #-----------------|------------------|
            | name            | my-private-alias |
            | type            | A                |
