Feature: Test a basic tfvars configuration apply for the alias-lb module.
    
    Scenario Outline: Initialize testing for alias-lb module using public lb.
        Given terraform module 'alias-lb'
            | key      | value        |
            #----------|--------------|
            | hostname | "<hostname>" |
            | domain   | "<domain>"   |
            | lb_name  | "public"     |

        When we run terraform apply
        
        Then terraform has outputs
            | var  | value                |
            #------|----------------------|
            | fqdn |  <hostname>.<domain> |
        
        And terraform wait for DNS lookup from output 'fqdn'
        
    Examples: hostname:domain pairs
        | hostname                    | domain                            |
        #-----------------------------|-----------------------------------|
        | behave-test-alias-lb-delete | as-test.techservices.illinois.edu |
