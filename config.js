require('dotenv').config({ path: __dirname + '/./.env' });

let AWS_DEPLOY = "$awsDeploy";
let licenseId = AWS_DEPLOY;
let deploymentType = "$deploymentType"
let frontEndUrl = "$frontEndUrl"
const frontEndUrls_Prod_All = "$frontEndUrls_Prod_All".split(",");
let allFrontEndUrls = ["http://localhost:4200", "https://awsportal.vultara.com", ...frontEndUrls_Prod_All];
let s3ReportsBucketName = "$s3ReportsBucketName";
let s3ImportBucketName = "$s3ImportBucketName";
let feasabilitySageMakerEndPointName = "feasibility-en";
let awsSecretManagerName = "$awsSecretManagerName";
let APPServerRootHTTPURL = "$APPServerRootHTTPURL";
let ReportServerHTTPURL = "$ReportServerHTTPURL";
let ssoClientId = "$ssoClientId";
let tenantId = "$tenantId";
let lambdaExecSecurityGroups = "$lambdaExecSecurityGroups";
let subnet1 = "$subnet1";
let subnet2 = "$subnet2";
let jiraEmail = "$jiraEmail";
const exportJira = "$exportJira" === "ON" ? true : false;
const hideNonSsoLogin = "$hideNonSsoLogin" === "ON" ? true : false;
let logGroupName = "$logGroupName";
let logStreamName = "$logStreamName";
const jiraApiKey = "VmSRoslO14Ov1SKVClXKED49";
const jiraDomain = "vultara";
const jiraProjectId = 10007;
let accessToken = process.env.ACCESS_TOKEN;
let atlasDb = process.env.ATLASDB;
let algoDb = process.env.ATLASDB_ALGOREAD;
let userAccessDb = process.env.ATLASDB_USERACCESS;
let dataAnalyticsDb = process.env.ATLASDB_DATAANALYTICS;
let componentDb = process.env.ATLASDB_COMPONENTREAD;
let helpDb = process.env.ATLASTRIALDB_HELPREAD;
let customerDiagnosticDb = process.env.ATLASDB_CUSTOMERDIAGNOSTIC;
let customerLicenseDb = process.env.ATLASDB_CUSTOMERLICENSE;
let jwtSecretKey = process.env.JWT_SECRET_KEY;
let cveApiKey = process.env.cveApiKey;
let dbName = "MongoDB Atlas librariesCustomer";
let dbNameAlgo = "MongoDB Atlas VultaraDB Cluster0-algorithmDb";
let dbNameDataAnalytics = "MongoDB Atlas dataAnalytics";
let dbNameComponent = "MongoDB Atlas componentDb";
let azureAdIssuerUrl = `https://login.microsoftonline.com/${tenantId}/v2.0`; // for SSO
const microsoftPublicKey = "https://login.microsoftonline.com/common/discovery/keys";

module.exports.licenseId = licenseId;
module.exports.deploymentType = deploymentType;
module.exports.frontEndUrl = frontEndUrl;
module.exports.allFrontEndUrls = allFrontEndUrls;
module.exports.frontEndUrls_Prod_All = frontEndUrls_Prod_All;
module.exports.s3HelpPageBucketName = "vultara-help-page-bucket";
module.exports.s3ReportsBucketName = s3ReportsBucketName;
module.exports.feasabilitySageMakerEndPointName = feasabilitySageMakerEndPointName;
module.exports.awsSecretManagerName = awsSecretManagerName;
module.exports.nvdDatabaseS3 = {
    aws: {
        region: "us-east-1",
        awsBaseUrl: "https://vultara-nvdsync-data.s3.amazonaws.com",
        awsBucket: "vultara-nvdsync-data"
    }
}
module.exports.ACCESS_TOKEN = accessToken;
module.exports.APPServerRootHTTPURL = APPServerRootHTTPURL;
module.exports.ReportServerHTTPURL = ReportServerHTTPURL;
module.exports.atlasDb = atlasDb;
module.exports.algoDb = algoDb;
module.exports.userAccessDb = userAccessDb;
module.exports.dataAnalyticsDb = dataAnalyticsDb;
module.exports.componentDb = componentDb;
module.exports.helpDb = helpDb;
module.exports.dbName = dbName;
module.exports.dbNameAlgo = dbNameAlgo;
module.exports.dbNameDataAnalytics = dbNameDataAnalytics;
module.exports.dbNameComponent = dbNameComponent;
module.exports.customerDiagnosticDb = customerDiagnosticDb;
module.exports.customerLicenseDb = customerLicenseDb;

//Azure Ad variables
module.exports.azureAdAppId = ssoClientId;
module.exports.azureAdTenantId = tenantId;
module.exports.azureAdIssuerUrl = azureAdIssuerUrl;
module.exports.microsoftPublicKey = microsoftPublicKey;

// serverless deployment variables
module.exports.lambdaExecSecurityGroups = lambdaExecSecurityGroups;
module.exports.serverlessDeploySubnet1 = subnet1;
module.exports.serverlessDeploySubnet2 = subnet2;

// Jira API variables
module.exports.jiraEmail = jiraEmail;
module.exports.exportJira = exportJira;
module.exports.jiraApiKey = jiraApiKey;
module.exports.jiraDomain = jiraDomain;
module.exports.jiraProjectId = jiraProjectId;

// JWT secret key
module.exports.jwtSecretKey = jwtSecretKey;

// CVE api key for nvd nist api
module.exports.cveApiKey = cveApiKey;

// s3 bucket name to upload file 
module.exports.s3ImportBucketName = s3ImportBucketName;

// For hide/show non SSO login page
module.exports.hideNonSsoLogin = hideNonSsoLogin;
// log group name and log stream name
module.exports.logGroupName = logGroupName;
module.exports.logStreamName = logStreamName;