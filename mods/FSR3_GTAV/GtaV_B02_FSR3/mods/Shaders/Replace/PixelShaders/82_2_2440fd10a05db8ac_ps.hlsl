// ---- FNV Hash 2440fd10a05db8ac

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:21 2023

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

  r0.xyzw = PlateBgSampler.Sample(PlateBgSampler_s, v1.xy).xyzw;
  r1.xy = LicensePlateFontExtents.zw + -LicensePlateFontExtents.xy;
  r1.xy = float2(8,1) / r1.xy;
  r1.zw = saturate(-LicensePlateFontExtents.xy + v1.xy);
  r2.xy = r1.zw * r1.xy;
  r2.xy = trunc(r2.xy);
  r1.xy = r1.zw * r1.xy + -r2.xy;
  r1.z = (int)r2.x;
  r2.xyzw = cmp((int4)r1.zzzz == int4(0,1,2,3));
  r2.xyzw = r2.xyzw ? float4(1,1,1,1) : 0;
  r3.xyzw = cmp((int4)r1.zzzz == int4(4,5,6,7));
  r3.xyzw = r3.xyzw ? float4(1,1,1,1) : 0;
  r1.z = dot(LetterIndex1.xyzw, r2.xyzw);
  r1.w = dot(LetterIndex2.xyzw, r3.xyzw);
  r1.z = r1.z + r1.w;
  r1.z = trunc(r1.z);
  r1.z = r1.z / NumLetters.x;
  r1.w = trunc(r1.z);
  r2.x = r1.z + -r1.w;
  r2.y = r1.w / NumLetters.y;
  r1.xy = r1.xy * LetterSize.xy + r2.xy;
  r1.zw = ddx(v1.xy);
  r1.zw = float2(0.5,0.5) * r1.zw;
  r2.xy = ddy(v1.xy);
  r2.xy = float2(0.5,0.5) * r2.xy;
  r3.xyzw = FontSampler.SampleGrad(FontSampler_s, r1.xy, r1.zwzz, r2.xyxx).xyzw;
  r4.xy = cmp(v1.xy < LicensePlateFontExtents.xy);
  r4.zw = cmp(LicensePlateFontExtents.zw < v1.xy);
  r4.xyzw = r4.xyzw ? float4(1,1,1,1) : 0;
  r2.z = dot(r4.xyzw, r4.xyzw);
  r2.z = min(1, r2.z);
  r2.w = r2.z * -r3.x + r3.x;
  r3.xy = max(abs(r2.xy), abs(r1.zw));
  r3.x = max(r3.x, r3.y);
  r3.xy = DistEpsilonScaleMin.xy * r3.xx;
  r3.xy = max(DistEpsilonScaleMin.zw, r3.xy);
  r3.x = DistMapCenterVal + -r3.x;
  r3.y = DistMapCenterVal + r3.y;
  r3.y = r3.y + -r3.x;
  r2.w = -r3.x + r2.w;
  r3.x = 1 / r3.y;
  r2.w = saturate(r3.x * r2.w);
  r3.x = r2.w * -2 + 3;
  r2.w = r2.w * r2.w;
  r2.w = r3.x * r2.w;
  r3.xyz = LicensePlateFontTint.www * LicensePlateFontTint.xyz + -r0.xyz;
  r3.xyz = r2.www * r3.xyz + r0.xyz;
  r0.xyz = matDiffuseColor.xyz * r3.xyz;
  r0.xyzw = v3.xxxw * r0.xyzw;
  r0.w = globalScalars.x * r0.w;
  r3.x = cmp(0.00392156886 >= r0.w);
  if (r3.x != 0) discard;
  r3.xyzw = PlateBgBumpSampler.Sample(PlateBgBumpSampler_s, v1.xy).xyzw;
  r1.xyzw = FontNormalSampler.SampleGrad(FontNormalSampler_s, r1.xy, r1.zwzz, r2.xyxx).xyzw;
  r1.xy = r2.zz * -r1.xy + r1.xy;
  r1.xy = float2(-0.5,-0.5) + r1.xy;
  r1.xy = FontNormalScale * r1.xy;
  r1.xy = r1.xy * r2.ww + r3.xy;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r1.xy, r1.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r1.w = max(0.00100000005, bumpiness);
  r1.xy = r1.xy * r1.ww;
  r2.xyz = v6.xyz * r1.yyy;
  r1.xyw = r1.xxx * v5.xyz + r2.xyz;
  r1.xyz = r1.zzz * v2.xyz + r1.xyw;
  r1.x = dot(r1.xyz, r1.xyz);
  r1.x = rsqrt(r1.x);
  r1.y = globalScalars.z * v3.x;
  r1.w = 0.200000003 * v3.x;
  r2.xy = float2(1,2) + -dirtLevelMod.zz;
  r2.z = v3.z * r2.x;
  r2.yw = v1.zw * r2.yy;
  r3.xyzw = DirtSampler.Sample(DirtSampler_s, r2.yw).xyzw;
  r2.y = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r2.w = r3.z + -r3.x;
  r3.x = r2.y * r2.w + r3.x;
  r2.yw = dirtLevelMod.xx * r3.xy;
  r3.x = v3.z * r2.x + -1;
  r2.x = r2.x * r3.x + 1;
  r2.y = r2.y * r2.x;
  r3.xyw = dirtColor.xyz * dirtLevelMod.yyy + -r0.xyz;
  r0.xyz = r2.yyy * r3.xyw + r0.xyz;
  r2.y = dirtLevelMod.x * r2.z;
  r3.xyz = r3.zzz + -r0.xyz;
  r0.xyz = r2.yyy * r3.xyz + r0.xyz;
  r2.x = -r2.w * r2.x + 1;
  r1.w = r2.x * r1.w;
  r1.x = r1.z * r1.x + -0.349999994;
  r1.x = saturate(1.53846157 * r1.x);
  r1.x = gDynamicBakesAndWetness.z * r1.x;
  r1.z = 1 + -globalScalars2.z;
  r1.x = r1.x * r1.z;
  r1.x = r1.x * r1.y;
  r1.y = -r1.w * 0.5 + 1;
  r1.x = r1.x * r1.y;
  r1.x = r1.x * -0.5 + 1;
  o0.xyz = r1.xxx * r0.xyz;
  o0.w = r0.w;
  return;
}