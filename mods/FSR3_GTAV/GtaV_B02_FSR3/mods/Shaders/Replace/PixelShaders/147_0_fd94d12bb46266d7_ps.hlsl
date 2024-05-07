// ---- FNV Hash fd94d12bb46266d7

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
}

cbuffer megashader_locals : register(b12)
{
  float emissiveMultiplier : packoffset(c0);
  float specularFresnel : packoffset(c0.y);
  float specularFalloffMult : packoffset(c0.z);
  float specularIntensityMult : packoffset(c0.w);
  float bumpiness : packoffset(c1);
  float reflectivePower : packoffset(c1.y);
  float useTessellation : packoffset(c1.z);
  float HardAlphaBlend : packoffset(c1.w);
}

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

SamplerState DiffuseSampler_s : register(s0);
SamplerState BumpSampler_s : register(s2);
SamplerState EnvironmentSampler_s : register(s3);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> BumpSampler : register(t2);
Texture2D<float4> EnvironmentSampler : register(t3);
Texture2D<float4> FogRaySampler : register(t11);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  linear centroid float4 v0 : COLOR0,
  float3 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD6,
  float4 v7 : SV_Position0,
  float4 v8 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float o1 : SV_Target1,
  out float o2 : SV_Target2,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24,r25;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.xyzw = BumpSampler.Sample(BumpSampler_s, v1.xy).xyzw;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r1.xy, r1.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r1.w = max(0.00100000005, bumpiness);
  r1.xy = r1.xy * r1.ww;
  r2.xyz = v5.xyz * r1.yyy;
  r1.xyw = r1.xxx * v4.xyz + r2.xyz;
  r1.xyz = r1.zzz * v2.xyz + r1.xyw;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r1.xyz * r1.www;
  r1.x = dot(v3.xyz, v3.xyz);
  r1.x = rsqrt(r1.x);
  r3.xyz = v3.xyz * r1.xxx;
  r1.x = dot(-r3.xyz, r2.xyz);
  r1.x = r1.x + r1.x;
  r3.xyz = r2.xyz * -r1.xxx + -r3.xyz;
  r1.x = dot(r3.xyz, r3.xyz);
  r1.x = rsqrt(r1.x);
  r1.xy = r3.xz * r1.xx + float2(1,1);
  r1.xy = float2(-0.5,-0.5) * r1.xy;
  r3.xyzw = EnvironmentSampler.Sample(EnvironmentSampler_s, r1.xy).xyzw;
  r3.xyz = reflectivePower * r3.xyz;
  r1.x = cmp(globalScalars.w == 0.000000);
  r1.x = r1.x ? 0 : 1;
  r3.xyz = r3.xyz * r1.xxx;
  r1.x = emissiveMultiplier * r0.w;
  r1.x = globalScalars.w * r1.x;
  r1.x = globalScalars2.y * r1.x;
  r0.w = v0.w * r0.w;
  r4.xy = globalScalars.zy * v0.xy;
  r1.x = v0.z * r1.x;
  r0.xyz = r0.xyz * r0.xyz;
  r5.xyz = gViewInverse._m30_m31_m32 + -v6.xyz;
  r1.y = dot(r5.xyz, r5.xyz);
  r1.y = rsqrt(r1.y);
  r6.xyz = r5.xyz * r1.yyy;
  r7.xyz = r5.xyz * r1.yyy + -gDirectionalLight.xyz;
  r1.y = dot(r7.xyz, r7.xyz);
  r1.y = rsqrt(r1.y);
  r7.xyz = r7.xyz * r1.yyy;
  r1.y = saturate(specularIntensityMult);
  r4.xy = r4.xy * r4.xy;
  r2.w = -500 + specularFalloffMult;
  r2.w = max(0, r2.w);
  r3.w = specularFalloffMult + -r2.w;
  r2.w = 558 * r2.w;
  r2.w = r3.w * 3 + r2.w;
  r3.w = dot(r5.xyz, gViewInverse._m20_m21_m22);
  r5.xyz = -gViewInverse._m30_m31_m32 + v6.xyz;
  r8.xyz = gCSMShaderVars_shared[1].xyz * r5.yyy;
  r8.xyz = r5.xxx * gCSMShaderVars_shared[0].xyz + r8.xyz;
  r8.xyz = r5.zzz * gCSMShaderVars_shared[2].xyz + r8.xyz;
  r9.xyz = r8.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r9.xyz;
  r10.xyz = r8.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r10.xyz;
  r11.xyz = r8.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r11.xyz;
  r8.xyz = r8.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r8.xyz;
  r12.yw = float2(-0.346096516,0.32848981) * gCSMResolution.zw;
  r4.z = -gCSMResolution.z * 1.5 + 1;
  r4.z = 0.5 * r4.z;
  r4.w = max(abs(r11.x), abs(r11.y));
  r4.w = cmp(r4.w < r4.z);
  r4.w = r4.w ? 2 : 3;
  r5.w = max(abs(r10.x), abs(r10.y));
  r5.w = cmp(r5.w < r4.z);
  r4.w = r5.w ? 1 : r4.w;
  r5.w = max(abs(r9.x), abs(r9.y));
  r4.z = cmp(r5.w < r4.z);
  r4.z = r4.z ? 0 : r4.w;
  r9.xyz = x0[r4.z+0].xyz;
  r4.z = (int)r4.z;
  r4.w = 0.5 + r4.z;
  r4.w = 0.25 * r4.w;
  r10.xyzw = cmp(float4(0,1,2,3) == r4.zzzz);
  r10.xyzw = r10.xyzw ? float4(1,1,1,1) : 0;
  r4.z = dot(r10.xyzw, gCSMDepthBias.xyzw);
  r5.w = dot(r10.xyzw, gCSMDepthSlopeBias.xyzw);
  r10.x = 0.5 + r9.x;
  r10.y = r9.y * 0.25 + r4.w;
  r4.w = cmp(r4.z != 0.000000);
  r4.z = r9.z + -r4.z;
  r11.xyw = ddx(r10.xyy);
  r11.z = ddx(r4.z);
  r13.xyz = ddy(r10.yxy);
  r13.w = ddy(r4.z);
  r8.zw = r13.yw * r11.yw;
  r14.xy = r11.xz * r13.xz + -r8.zw;
  r6.w = 1 / r14.x;
  r7.w = r13.y * r11.z;
  r14.z = r11.x * r13.w + -r7.w;
  r8.zw = r14.yz * r6.ww;
  r8.zw = max(float2(0,0), r8.zw);
  r8.zw = min(float2(0.5,0.5), r8.zw);
  r4.z = -r5.w * r8.z + r4.z;
  r4.z = -r5.w * r8.w + r4.z;
  r12.z = r4.w ? r4.z : r9.z;
  r10.z = 0;
  r9.xyz = r12.ywz + r10.xyz;
  r12.xy = float2(-0.799291492,0.201740593) * gCSMResolution.zw;
  r11.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(-0.0311755072,0.179337755) * gCSMResolution.zw;
  r13.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(0.514749467,0.253502458) * gCSMResolution.zw;
  r14.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(-0.0728697181,0.00809734128) * gCSMResolution.zw;
  r15.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(-0.96978128,0.0345216095) * gCSMResolution.zw;
  r16.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(0.545546651,0.0241285414) * gCSMResolution.zw;
  r17.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(-0.0289061088,-0.136784583) * gCSMResolution.zw;
  r18.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(-0.47951147,-0.244832873) * gCSMResolution.zw;
  r19.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(0.758788407,-0.112109199) * gCSMResolution.zw;
  r20.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(0.339352578,-0.249327824) * gCSMResolution.zw;
  r21.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(1.07059765,0.208122596) * gCSMResolution.zw;
  r22.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(1.29403818,-0.0180776753) * gCSMResolution.zw;
  r23.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(-0.747563064,-0.113974348) * gCSMResolution.zw;
  r24.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(0.94772172,-0.248763546) * gCSMResolution.zw;
  r25.xyz = r12.xyz + r10.xyz;
  r12.xy = float2(-1.34315288,-0.088584058) * gCSMResolution.zw;
  r10.xyz = r12.xyz + r10.xyz;
  r9.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r9.xy, r9.z).x;
  r9.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r11.xy, r11.z).x;
  r9.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r13.xy, r13.z).x;
  r9.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r14.xy, r14.z).x;
  r11.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r15.xy, r15.z).x;
  r11.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r16.xy, r16.z).x;
  r11.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r17.xy, r17.z).x;
  r11.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r18.xy, r18.z).x;
  r12.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r19.xy, r19.z).x;
  r12.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r20.xy, r20.z).x;
  r12.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r21.xy, r21.z).x;
  r12.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r22.xy, r22.z).x;
  r13.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r23.xy, r23.z).x;
  r13.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r24.xy, r24.z).x;
  r13.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r25.xy, r25.z).x;
  r13.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r10.xy, r10.z).x;
  r9.xyzw = r11.xyzw + r9.xyzw;
  r9.xyzw = r9.xyzw + r12.xyzw;
  r9.xyzw = r9.xyzw + r13.xyzw;
  r4.z = dot(r9.xyzw, float4(1,1,1,1));
  r3.w = saturate(r3.w * gCSMShaderVars_shared[0].w + gCSMShaderVars_shared[1].w);
  r4.w = max(abs(r8.x), abs(r8.y));
  r4.w = saturate(r4.w * 15 + -6.30000019);
  r3.w = 1 + -r3.w;
  r3.w = r3.w * r4.w;
  r3.w = r4.z * 0.0625 + r3.w;
  r3.w = r3.w * r3.w;
  r3.w = min(1, r3.w);
  r4.z = saturate(v6.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r4.z = sqrt(r4.z);
  r4.z = gCSMShaderVars_shared[3].z * r4.z;
  r3.w = r4.z * -r3.w + r3.w;
  r4.z = saturate(dot(r2.xyz, -gDirectionalLight.xyz));
  r6.x = saturate(dot(r6.xyz, r2.xyz));
  r6.y = saturate(dot(r7.xyz, -gDirectionalLight.xyz));
  r6.yz = float2(1,1) + -r6.xy;
  r8.xy = r6.yz * r6.yz;
  r8.xy = r8.xy * r8.xy;
  r6.yz = r8.xy * r6.yz;
  r4.w = 1 + -specularFresnel;
  r6.yz = specularFresnel * r6.yz + r4.ww;
  r8.xy = float2(2,9.99999994e-09) + r2.ww;
  r4.w = 0.125 * r8.x;
  r5.w = -r1.y * r6.y + 1;
  r6.y = dot(r2.xyz, r7.xyz);
  r6.y = saturate(9.99999994e-09 + r6.y);
  r6.y = log2(r6.y);
  r6.y = r8.y * r6.y;
  r6.y = exp2(r6.y);
  r6.y = r6.y * r6.z;
  r4.w = r6.y * r4.w;
  r1.y = r4.w * r1.y;
  r1.y = r1.y * r4.z;
  r4.z = r5.w * r4.z;
  r6.yzw = r0.xyz * r4.zzz + r1.yyy;
  r6.yzw = gDirectionalColour.xyz * r6.yzw;
  r1.y = r1.z * r1.w + gLightNaturalAmbient0.w;
  r1.y = gLightNaturalAmbient1.w * r1.y;
  r1.y = max(0, r1.y);
  r7.xyz = gLightArtificialExtAmbient0.xyz * r1.yyy + gLightArtificialExtAmbient1.xyz;
  r1.z = 1 + -globalScalars2.z;
  r8.xyz = gLightArtificialIntAmbient0.xyz * r1.yyy + gLightArtificialIntAmbient1.xyz;
  r8.xyz = globalScalars2.zzz * r8.xyz;
  r7.xyz = r7.xyz * r1.zzz + r8.xyz;
  r7.xyz = r7.xyz * r4.yyy;
  r1.yzw = gLightNaturalAmbient0.xyz * r1.yyy + gLightNaturalAmbient1.xyz;
  r8.x = gLightArtificialIntAmbient1.w;
  r8.y = gLightArtificialExtAmbient0.w;
  r8.z = gLightArtificialExtAmbient1.w;
  r2.x = saturate(dot(r8.xyz, r2.xyz));
  r1.yzw = gDirectionalAmbientColour.xyz * r2.xxx + r1.yzw;
  r1.yzw = r1.yzw * r4.xxx + r7.xyz;
  r1.yzw = r1.yzw * r5.www;
  r1.yzw = r1.yzw * r0.xyz;
  r1.yzw = r6.yzw * r3.www + r1.yzw;
  r2.x = 1 + -r5.w;
  r2.y = max(r4.x, r4.y);
  r3.xyz = r3.xyz * r2.yyy;
  r2.y = saturate(0.00177619897 * r2.w);
  r2.yzw = r3.xyz * r2.yyy;
  r2.yzw = float3(0.681690097,0.681690097,0.681690097) * r2.yzw;
  r2.yzw = r3.xyz * float3(0.318309903,0.318309903,0.318309903) + r2.yzw;
  r1.yzw = r2.yzw * r2.xxx + r1.yzw;
  r1.x = r6.x * r1.x;
  r0.xyz = r0.xyz * r1.xxx + r1.yzw;
  r0.w = globalScalars.x * r0.w;
  if (gUseFogRay != 0) {
    r1.x = dot(r5.xyz, r5.xyz);
    r1.y = sqrt(r1.x);
    r1.z = -globalFogParams[0].x + r1.y;
    r1.z = max(0, r1.z);
    r1.y = r1.z / r1.y;
    r1.y = r5.z * r1.y;
    r1.w = globalFogParams[2].z * r1.y;
    r1.y = cmp(0.00999999978 < abs(r1.y));
    r2.x = -1.44269502 * r1.w;
    r2.x = exp2(r2.x);
    r2.x = 1 + -r2.x;
    r1.w = r2.x / r1.w;
    r1.y = r1.y ? r1.w : 1;
    r1.w = globalFogParams[1].w * r1.z;
    r1.y = r1.w * r1.y;
    r1.y = min(1, r1.y);
    r1.y = 1.44269502 * r1.y;
    r1.y = exp2(r1.y);
    r1.y = min(1, r1.y);
    r1.y = 1 + -r1.y;
    r1.w = globalFogParams[2].y * r1.y;
    r1.x = rsqrt(r1.x);
    r2.xyz = r5.xyz * r1.xxx;
    r1.x = saturate(dot(r2.xyz, globalFogParams[4].xyz));
    r1.x = log2(r1.x);
    r1.x = globalFogParams[4].w * r1.x;
    r1.x = exp2(r1.x);
    r2.x = saturate(dot(r2.xyz, globalFogParams[3].xyz));
    r2.x = log2(r2.x);
    r2.x = globalFogParams[3].w * r2.x;
    r2.x = exp2(r2.x);
    r1.y = -r1.y * globalFogParams[2].y + 1;
    r1.y = globalFogParams[1].y * r1.y;
    r2.y = -globalFogParams[2].x + r1.z;
    r2.y = max(0, r2.y);
    r2.y = globalFogParams[1].x * r2.y;
    r2.y = 1.44269502 * r2.y;
    r2.y = exp2(r2.y);
    r2.y = 1 + -r2.y;
    r1.w = saturate(r1.y * r2.y + r1.w);
    r1.z = -globalFogParams[1].z * r1.z;
    r1.z = 1.44269502 * r1.z;
    r1.z = exp2(r1.z);
    r1.z = 1 + -r1.z;
    r2.yzw = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r2.yzw = r1.xxx * r2.yzw + globalFogColorE.xyz;
    r3.xyz = globalFogColor.xyz + -r2.yzw;
    r2.xyz = r2.xxx * r3.xyz + r2.yzw;
    r2.xyz = -globalFogColorN.xyz + r2.xyz;
    r2.xyz = r1.zzz * r2.xyz + globalFogColorN.xyz;
    r3.x = globalFogColor.w;
    r3.y = globalFogColorE.w;
    r3.z = globalFogColorN.w;
    r3.xyz = r3.xyz + -r2.xyz;
    r1.xyz = r1.yyy * r3.xyz + r2.xyz;
    r2.x = cmp(0 < gGlobalFogIntensity);
    if (r2.x != 0) {
      r2.xy = globalScreenSize.zw * v7.xy;
      r2.xyzw = FogRaySampler.Sample(FogRaySampler_s, r2.xy).xyzw;
      r2.x = -1 + r2.x;
      r2.x = saturate(gGlobalFogIntensity * r2.x + 1);
    } else {
      r2.x = 1;
    }
    r1.xyz = r1.xyz * r2.xxx + -r0.xyz;
    r1.xyz = r1.www * r1.xyz + r0.xyz;
  } else {
    r1.w = dot(r5.xyz, r5.xyz);
    r2.x = sqrt(r1.w);
    r2.y = -globalFogParams[0].x + r2.x;
    r2.y = max(0, r2.y);
    r2.x = r2.y / r2.x;
    r2.x = r5.z * r2.x;
    r2.z = globalFogParams[2].z * r2.x;
    r2.x = cmp(0.00999999978 < abs(r2.x));
    r2.w = -1.44269502 * r2.z;
    r2.w = exp2(r2.w);
    r2.w = 1 + -r2.w;
    r2.z = r2.w / r2.z;
    r2.x = r2.x ? r2.z : 1;
    r2.z = globalFogParams[1].w * r2.y;
    r2.x = r2.z * r2.x;
    r2.x = min(1, r2.x);
    r2.x = 1.44269502 * r2.x;
    r2.x = exp2(r2.x);
    r2.x = min(1, r2.x);
    r2.x = 1 + -r2.x;
    r2.z = globalFogParams[2].y * r2.x;
    r1.w = rsqrt(r1.w);
    r3.xyz = r5.xyz * r1.www;
    r1.w = saturate(dot(r3.xyz, globalFogParams[4].xyz));
    r1.w = log2(r1.w);
    r1.w = globalFogParams[4].w * r1.w;
    r1.w = exp2(r1.w);
    r2.w = saturate(dot(r3.xyz, globalFogParams[3].xyz));
    r2.w = log2(r2.w);
    r2.w = globalFogParams[3].w * r2.w;
    r2.w = exp2(r2.w);
    r2.x = -r2.x * globalFogParams[2].y + 1;
    r2.x = globalFogParams[1].y * r2.x;
    r3.x = -globalFogParams[2].x + r2.y;
    r3.x = max(0, r3.x);
    r3.x = globalFogParams[1].x * r3.x;
    r3.x = 1.44269502 * r3.x;
    r3.x = exp2(r3.x);
    r3.x = 1 + -r3.x;
    r2.z = saturate(r2.x * r3.x + r2.z);
    r2.y = -globalFogParams[1].z * r2.y;
    r2.y = 1.44269502 * r2.y;
    r2.y = exp2(r2.y);
    r2.y = 1 + -r2.y;
    r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r3.xyz = r1.www * r3.xyz + globalFogColorE.xyz;
    r4.xyz = globalFogColor.xyz + -r3.xyz;
    r3.xyz = r2.www * r4.xyz + r3.xyz;
    r3.xyz = -globalFogColorN.xyz + r3.xyz;
    r3.xyz = r2.yyy * r3.xyz + globalFogColorN.xyz;
    r4.x = globalFogColor.w;
    r4.y = globalFogColorE.w;
    r4.z = globalFogColorN.w;
    r4.xyz = r4.xyz + -r3.xyz;
    r2.xyw = r2.xxx * r4.xyz + r3.xyz;
    r2.xyw = r2.xyw + -r0.xyz;
    r1.xyz = r2.zzz * r2.xyw + r0.xyz;
  }
  o0.xyz = globalScalars3.zzz * r1.xyz;
  r0.x = cmp(0.300000012 < r0.w);
  r0.x = r0.x ? 1.000000 : 0;
  o1.x = v1.z * r0.x;
  o0.w = r0.w;
  o2.x = r0.x;
  return;
}