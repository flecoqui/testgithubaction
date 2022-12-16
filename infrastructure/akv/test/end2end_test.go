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

		keyVaultId := terraform.Output(t, terraformOptions, "key_vault_id")
		keyVaultName := terraform.Output(t, terraformOptions, "key_vault_name")
		keyVaultSubscriptionId := terraform.Output(t, terraformOptions, "key_vault_subscription_id")
		keyVaultRg := terraform.Output(t, terraformOptions, "key_vault_rg")
		keyVaultUrl := terraform.Output(t, terraformOptions, "key_vault_url")
		keyVaultSecrets := terraform.Output(t, terraformOptions, "key_vault_secrets")
		keyVaultPolicies := terraform.Output(t, terraformOptions, "key_vault_policies")

		// Check that output is not empty
		assert.NotEmpty(t, keyVaultId, "keyVaultId is empty")
		assert.NotEmpty(t, keyVaultName, "keyVaultName is empty")
		assert.NotEmpty(t, keyVaultSubscriptionId, "keyVaultSubscriptionId is empty")
		assert.NotEmpty(t, keyVaultRg, "keyVaultRg is empty")
		assert.NotEmpty(t, keyVaultUrl, "keyVaultUrl is empty")
		assert.NotEmpty(t, keyVaultSecrets, "keyVaultSecrets is empty")
		assert.NotEmpty(t, keyVaultPolicies, "keyVaultPolicies is empty")
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
