Feature: Test a basic tfvars configuration for the alias-lb module.

    Background:
        Given the following variables
            | key      | value                             |
            #----------|-----------------------------------|
            | hostname | behave-test-alias-lb-${random:10} |

    
    Scenario: Initialize testing for alias-lb module using private lb.
        
        Given terraform module 'alias-lb'
            | key      | value             |
            #----------|-------------------|
            | hostname | "${var.hostname}" |
            | domain   | "local"           |
            | lb_name  | "private1"        |

        When we run terraform plan
        
        Then terraform plans to perform these exact resource actions
            | action | resource           | name       | count |
            #--------|--------------------|------------|-------|
            | create | aws_route53_record | default    |       |

        Then terraform resource 'aws_route53_record' 'default' has changed attributes
            | attr            | value           |
            #-----------------|-----------------|
            | name            | ${var.hostname} |
            | type            | A               |
