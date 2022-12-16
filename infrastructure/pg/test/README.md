# Testing the Terraform PostgreSQL Flexible Server Module

## Presentation

This directory contains the end-to-end test for the Terraform PostgreSQL Flexible Server Module. It actually:

- applies the provided example of execution of the PostgreSQL Flexible Server Terraform module
- parses the example Terraform Output and validates that it's behaving as expected
- connects to the created Azure Virtual Machine to access the PostgreSQL Flexible Server from the same Virtual Network
- checks that PostgreSQL Flexible Server is reachable using NetCat command

## Tests Execution

Before running the tests, you need to be logged to your Azure CLI via the `az login` command.

The end-to-end tests can be executed using the `go test -timeout 30m` command. This command will be overriding the 10 minutes default timeout, as it can be short for our tests.

## Tests success

If the tests succeeded, the output will look like:

```
...
TestEndToEndDeploymentScenario 2020-12-07T13:17:07+01:00 logger.go:66: azurerm_resource_group.rg: Destruction complete after 46s
TestEndToEndDeploymentScenario 2020-12-07T13:17:07+01:00 logger.go:66: 
TestEndToEndDeploymentScenario 2020-12-07T13:17:07+01:00 logger.go:66: Destroy complete! Resources: 19 destroyed.
PASS
ok  	test	742.061s
```
