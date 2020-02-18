Feature: Test a basic tfvars configuration apply for the alias-lb module.
    Background:
        Given the following variables
            | key      | value                             |
            #----------|-----------------------------------|
            | hostname | behave-test-alias-lb-${random:10} |
            | domain   | as-drone.techservice.illinois.edu |


    Scenario: Initialize testing for alias-lb module using public lb.
        Given terraform module 'alias-lb'
            | key      | value             |
            #----------|-------------------|
            | hostname | "${var.hostname}" |
            | domain   | "${var.domain}"   |
            | lb_name  | "public1"         |

        When we run terraform apply
        
        Then terraform has outputs
            | var  | value                          |
            #------|--------------------------------|
            | fqdn |  ${var.hostname}.${var.domain} |
        
        And terraform wait for DNS lookup from output 'fqdn'
