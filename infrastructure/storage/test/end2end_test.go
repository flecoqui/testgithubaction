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

		storageBlobPrimaryUrl := terraform.Output(t, terraformOptions, "storage_blob_primary_url")
		storageBlobPrimaryHost := terraform.Output(t, terraformOptions, "storage_blob_primary_host")

		storagePrimaryAccessKey := fetchSensitiveOutput(t, terraformOptions, "storage_primary_access_key")
		storageSecondaryAccessKey := fetchSensitiveOutput(t, terraformOptions, "storage_secondary_access_key")
		storagePrimaryConnectionString := fetchSensitiveOutput(t, terraformOptions, "storage_primary_connection_string")
		storageSecondaryConnectionString := fetchSensitiveOutput(t, terraformOptions, "storage_secondary_connection_string")
		primaryBlobConnectionString := fetchSensitiveOutput(t, terraformOptions, "primary_blob_connection_string")
		secondaryBlobConnectionString := fetchSensitiveOutput(t, terraformOptions, "secondary_blob_connection_string")

		// Check that output is not empty
		assert.NotEmpty(t, storageBlobPrimaryUrl, "storageBlobPrimaryUrl is empty")
		assert.NotEmpty(t, storageBlobPrimaryHost, "storageBlobPrimaryHost is empty")
		assert.NotEmpty(t, storagePrimaryAccessKey, "storagePrimaryAccessKey is empty")
		assert.NotEmpty(t, storageSecondaryAccessKey, "storageSecondaryAccessKey is empty")
		assert.NotEmpty(t, storagePrimaryConnectionString, "storagePrimaryConnectionString is empty")
		assert.NotEmpty(t, storageSecondaryConnectionString, "storageSecondaryConnectionString is empty")
		assert.NotEmpty(t, primaryBlobConnectionString, "primaryBlobConnectionString is empty")
		assert.NotEmpty(t, secondaryBlobConnectionString, "secondaryBlobConnectionString is empty")
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
