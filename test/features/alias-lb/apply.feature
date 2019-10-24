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
        Then terraform ping host from output 'fqdn' succeeds
        And terraform url from output 'fqdn' returns status code '503'
        When we run terraform destroy
        # State file no longer has outputs
        Then ping host '<hostname>.<domain>' fails
        
    Examples: hostname:domain pairs
        | hostname                    | domain                            |
        #-----------------------------|-----------------------------------|
        | behave-test-alias-lb-delete | as-test.techservices.illinois.edu |