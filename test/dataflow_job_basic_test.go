package test

import (
	"os"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestDataflowJobBasic(t *testing.T) {
	t.Parallel()

	projectID := os.Getenv("GOOGLE_CLOUD_PROJECT")
	require.NotEmpty(t, projectID, "GOOGLE_CLOUD_PROJECT env var must be set")

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/dataflow/basic",
		Vars: map[string]interface{}{
			"environment":       "devl",
			"project_code":      "test",
			"region":            "us-central1",
			"base_name":         "terratest-basic",
			"project_id":        projectID,
			"template_gcs_path": "gs://dataflow-templates-us-central1/latest/Word_Count",
			"temp_gcs_location": "gs://" + projectID + "-dataflow-tmp/terratest",
		},
		NoColor: true,
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Allow the job a moment to transition from JOB_STATE_PENDING
	time.Sleep(30 * time.Second)

	jobID := terraform.Output(t, terraformOptions, "job_id")
	jobName := terraform.Output(t, terraformOptions, "job_name")
	jobProject := terraform.Output(t, terraformOptions, "job_project")
	jobRegion := terraform.Output(t, terraformOptions, "job_region")
	templateGCSPath := terraform.Output(t, terraformOptions, "template_gcs_path")

	assert.NotEmpty(t, jobID, "job_id must not be empty")
	assert.Equal(t, "test-terratest-basic-us-central1-devl", jobName)
	assert.Equal(t, projectID, jobProject)
	assert.Equal(t, "us-central1", jobRegion)
	assert.Equal(t, "gs://dataflow-templates-us-central1/latest/Word_Count", templateGCSPath)
}
