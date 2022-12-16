package test

import (
	"github.com/gruntwork-io/terratest/modules/logger"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEndToEndDeploymentScenario(t *testing.T) {
	t.Parallel()
	fixtureFolder := "../example"

	test_structure.RunTestStage(t, "setup", func() {
		terraformOptions := &terraform.Options{
			TerraformDir: fixtureFolder,
		}

		test_structure.SaveTerraformOptions(t, fixtureFolder, terraformOptions)
		terraform.InitAndApply(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "validate", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)

		postgresqlServerLogin := terraform.Output(t, terraformOptions, "postgresql_server_login")
		postgresqlServerPassword := fetchSensitiveOutput(t, terraformOptions, "postgresql_server_password")
		postgresqlServerFqdn := terraform.Output(t, terraformOptions, "postgresql_server_fqdn")

		// Check that output is not empty
		assert.NotEmpty(t, postgresqlServerLogin, "postgresqlServerLogin is empty")
		assert.NotEmpty(t, postgresqlServerPassword, "postgresqlServerPassword is empty")
		assert.NotEmpty(t, postgresqlServerFqdn, "postgresqlServerFqdn is empty")
	})

	test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)
		terraform.Destroy(t, terraformOptions)
	})
}

func fetchSensitiveOutput(t *testing.T, options *terraform.Options, name string) string {
	defer func() {
		options.Logger = nil
	}()
	options.Logger = logger.Discard
	return terraform.Output(t, options, name)
}
