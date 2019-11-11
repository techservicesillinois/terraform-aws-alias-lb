Feature: Test a basic tfvars configuration for the alias-lb module.
    
    
    Background: Initialize testing for alias-lb module using private lb.
        
        Given terraform module 'alias-lb'
            | key      | value                         |
            #----------|-------------------------------|
            | hostname | "ejtravis-behave-test-DELETE" |
            | domain   | "local"                       |
            | lb_name  | "private"                     |
        
    Scenario: Behave test engine runs a successful plan->apply->destroy
        When we run terraform plan
        When we run terraform apply
        When we run terraform destroy
        
    Scenario: Behave test engine runs a successful apply, automatically runs plan if DNE
        When we run terraform apply
        When we run terraform destroy
    
    Scenario: Behae test engine runs a successful apply, automatically runs other commands when appropriate
        # Should run terraform PLAN HERE
        When we run terraform apply
        # Should run terraform DESTROY HERE
    
    
    
