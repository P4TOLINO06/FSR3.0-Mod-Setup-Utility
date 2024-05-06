// ---- FNV Hash 24a3222d320f78b2

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:20 2023

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

cbuffer vehiclecommonlocals : register(b11)
{
  float3 matDiffuseColor : packoffset(c0);
  float4 matDiffuseColor2 : packoffset(c1);
  float4 dirtLevelMod : packoffset(c2);
  float3 dirtColor : packoffset(c3);
  float bumpiness : packoffset(c3.w);
  float reflectivePower : packoffset(c4);
  float envEffThickness : packoffset(c4.y);
  float2 envEffScale : packoffset(c4.z);
  float envEffTexTileUV : packoffset(c5);
}

cbuffer vehicle_licenseplate_locals : register(b9)
{
  float4 LetterIndex1 : packoffset(c0);
  float4 LetterIndex2 : packoffset(c1);
  float2 LetterSize : packoffset(c2);
  float2 NumLetters : packoffset(c2.z);
  float4 LicensePlateFontExtents : packoffset(c3);
  float4 LicensePlateFontTint : packoffset(c4);
  float FontNormalScale : packoffset(c5);
  float DistMapCenterVal : packoffset(c5.y);
  float4 DistEpsilonScaleMin : packoffset(c6);
  float3 FontOutlineMinMaxDepthEnabled : packoffset(c7);
  float3 FontOutlineColor : packoffset(c8);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState DirtSampler_s : register(s3);
SamplerState PlateBgSampler_s : register(s5);
SamplerState PlateBgBumpSampler_s : register(s6);
SamplerState FontSampler_s : register(s7);
SamplerState FontNormalSampler_s : register(s8);
Texture2D<float4> DirtSampler : register(t3);
Texture2D<float4> PlateBgSampler : register(t5);
Texture2D<float4> PlateBgBumpSampler : register(t6);
Texture2D<float4> FontSampler : register(t7);
Texture2D<float4> FontNormalSampler : register(t8);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float3 v6 : TEXCOORD5,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = LicensePlateFontExtents.zw + -LicensePlateFontExtents.xy;
  r0.xy = float2(8,1) / r0.xy;
  r0.zw = saturate(-LicensePlateFontExtents.xy + v1.xy);
  r1.xy = r0.zw * r0.xy;
  r1.xy = trunc(r1.xy);
  r1.z = (int)r1.x;
  r0.xy = r0.zw * r0.xy + -r1.xy;
  r2.xyzw = cmp((int4)r1.zzzz == int4(0,1,2,3));
  r1.xyzw = cmp((int4)r1.zzzz == int4(4,5,6,7));
  r1.xyzw = r1.xyzw ? float4(1,1,1,1) : 0;
  r0.z = dot(LetterIndex2.xyzw, r1.xyzw);
  r1.xyzw = r2.xyzw ? float4(1,1,1,1) : 0;
  r0.w = dot(LetterIndex1.xyzw, r1.xyzw);
  r0.z = r0.w + r0.z;
  r0.z = trunc(r0.z);
  r0.z = r0.z / NumLetters.x;
  r0.w = trunc(r0.z);
  r1.x = r0.z + -r0.w;
  r1.y = r0.w / NumLetters.y;
  r0.xy = r0.xy * LetterSize.xy + r1.xy;
  r0.zw = ddx(v1.xy);
  r0.zw = float2(0.5,0.5) * r0.zw;
  r1.xy = ddy(v1.xy);
  r1.xy = float2(0.5,0.5) * r1.xy;
  r2.xyzw = FontSampler.SampleGrad(FontSampler_s, r0.xy, r0.zwzz, r1.xyxx).xyzw;
  r3.xyzw = FontNormalSampler.SampleGrad(FontNormalSampler_s, r0.xy, r0.zwzz, r1.xyxx).xyzw;
  r0.xy = max(abs(r1.xy), abs(r0.zw));
  r0.x = max(r0.x, r0.y);
  r0.xy = DistEpsilonScaleMin.xy * r0.xx;
  r0.xy = max(DistEpsilonScaleMin.zw, r0.xy);
  r1.xy = cmp(v1.xy < LicensePlateFontExtents.xy);
  r1.zw = cmp(LicensePlateFontExtents.zw < v1.xy);
  r1.xyzw = r1.xyzw ? float4(1,1,1,1) : 0;
  r0.z = dot(r1.xyzw, r1.xyzw);
  r0.z = min(1, r0.z);
  r0.w = r0.z * -r2.x + r2.x;
  r1.xy = r0.zz * -r3.xy + r3.xy;
  r1.xy = float2(-0.5,-0.5) + r1.xy;
  r1.xy = FontNormalScale * r1.xy;
  r0.x = DistMapCenterVal + -r0.x;
  r0.y = DistMapCenterVal + r0.y;
  r0.y = r0.y + -r0.x;
  r0.x = r0.w + -r0.x;
  r0.y = 1 / r0.y;
  r0.x = saturate(r0.x * r0.y);
  r0.y = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.x = r0.y * r0.x;
  r2.xyzw = PlateBgSampler.Sample(PlateBgSampler_s, v1.xy).xyzw;
  r0.yzw = LicensePlateFontTint.www * LicensePlateFontTint.xyz + -r2.xyz;
  r0.yzw = r0.xxx * r0.yzw + r2.xyz;
  r2.xyz = matDiffuseColor.xyz * r0.yzw;
  r2.xyzw = v3.xxxw * r2.xyzw;
  r0.yzw = dirtColor.xyz * dirtLevelMod.yyy + -r2.xyz;
  r1.z = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r3.xy = float2(1,2) + -dirtLevelMod.zz;
  r3.yz = v1.zw * r3.yy;
  r4.xyzw = DirtSampler.Sample(DirtSampler_s, r3.yz).xyzw;
  r1.w = r4.z + -r4.x;
  r4.x = r1.z * r1.w + r4.x;
  r1.zw = dirtLevelMod.xx * r4.xy;
  r3.y = v3.z * r3.x + -1;
  r3.y = r3.x * r3.y + 1;
  r3.x = v3.z * r3.x;
  r3.x = dirtLevelMod.x * r3.x;
  r1.z = r3.y * r1.z;
  r1.w = -r1.w * r3.y + 1;
  r0.yzw = r1.zzz * r0.yzw + r2.xyz;
  o0.w = globalScalars.x * r2.w;
  r2.xyz = r4.zzz + -r0.yzw;
  r0.yzw = r3.xxx * r2.xyz + r0.yzw;
  r2.xyzw = PlateBgBumpSampler.Sample(PlateBgBumpSampler_s, v1.xy).xyzw;
  r1.xy = r1.xy * r0.xx + r2.xy;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r0.x = dot(r1.xy, r1.xy);
  r0.x = 1 + -r0.x;
  r0.x = sqrt(abs(r0.x));
  r1.z = max(0.00100000005, bumpiness);
  r1.xy = r1.xy * r1.zz;
  r2.xyz = v6.xyz * r1.yyy;
  r1.xyz = r1.xxx * v5.xyz + r2.xyz;
  r1.xyz = r0.xxx * v2.xyz + r1.xyz;
  r0.x = dot(r1.xyz, r1.xyz);
  r0.x = rsqrt(r0.x);
  r2.x = r1.z * r0.x + -0.349999994;
  r1.xyz = r1.xyz * r0.xxx;
  o1.xyz = r1.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.x = saturate(1.53846157 * r2.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r1.x = 1 + -globalScalars2.z;
  r0.x = r1.x * r0.x;
  r1.xy = globalScalars.zy * v3.xx;
  r0.x = r1.x * r0.x;
  r1.x = 0.200000003 * v3.x;
  r2.x = r1.x * r1.w;
  r1.x = saturate(r1.x * r1.w + 0.400000006);
  r1.z = -r2.x * 0.5 + 1;
  r1.z = r1.z * r0.x;
  r1.z = r1.z * -0.5 + 1;
  o0.xyz = r1.zzz * r0.yzw;
  o1.w = 0;
  r2.y = 0.9765625;
  r0.yz = r1.xx * float2(0.5,0.48828125) + -r2.xy;
  r0.yz = max(float2(0,0), r0.yz);
  r0.xy = r0.yz * r0.xx + r2.xy;
  o2.xy = sqrt(r0.xy);
  o2.zw = float2(0.980000019,1);
  r0.x = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r0.y = r1.y * r0.x;
  r0.x = v3.x * globalScalars.z + gLightArtificialIntAmbient0.w;
  r0.xy = float2(0.5,0.5) * r0.xy;
  o3.xy = sqrt(r0.xy);
  o3.zw = float2(0,1.00188386);
  return;
}