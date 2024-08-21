import packageInfo from '../../package.json';

export const environment = {
    production: true,
    frontendUrl: "",
    clientIdSso: "", // active directory registration ID for single sign on,
    tenantId: "",
    backendApiUrl: "$APPServerRootHTTPURL",
    authenticationApiUrl: "$authenticationApiUrl/",
    exportJira: "",
    protectModuleLicense: "",
    vulnerabilityModuleLicense: "",
    deploymentStatus: "prod",
    version: packageInfo.version,
    industry: "",
    complianceModules: "",
    loginImageDir: "$loginImageDir",
    socViewUrl: "$socUrl/",
    soc: "",
    threatIntelligenceModule: "",
    taraAutomationModule: "",
    deploymentType: "",
    ssoType: "",
    hideNonSsoLogin: false, // hide/show the non SSO section in login page.
};