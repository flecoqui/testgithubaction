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

		acrAdminUsername := terraform.Output(t, terraformOptions, "acr_admin_username")
		acrAdminPassword := fetchSensitiveOutput(t, terraformOptions, "acr_admin_password")
		acrUrl := terraform.Output(t, terraformOptions, "acr_url")
		acrResourceId := terraform.Output(t, terraformOptions, "acr_resource_id")

		// Check that output is not empty
		assert.NotEmpty(t, acrAdminUsername, "acrAdminUsername is empty")
		assert.NotEmpty(t, acrAdminPassword, "acrAdminPassword is empty")
		assert.NotEmpty(t, acrUrl, "acrUrl is empty")
		assert.NotEmpty(t, acrResourceId, "acrResourceId is empty")
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
