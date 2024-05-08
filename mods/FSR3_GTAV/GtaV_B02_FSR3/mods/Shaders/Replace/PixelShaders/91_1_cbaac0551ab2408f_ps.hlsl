// ---- FNV Hash cbaac0551ab2408f

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

cbuffer water_terrainfoam_locals : register(b10)
{
  float WaveOffset : packoffset(c0);
  float WaterHeight : packoffset(c0.y);
  float WaveMovement : packoffset(c0.z);
  float HeightOpacity : packoffset(c0.w);
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

SamplerState FoamSampler_s : register(s3);
SamplerState WetSampler_s : register(s9);
SamplerState WaterBumpSampler_s : register(s10);
Texture2D<float4> FoamSampler : register(t3);
Texture2D<float4> WetSampler : register(t9);
Texture2D<float4> WaterBumpSampler : register(t10);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
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
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 0;
  r1.xyzw = WetSampler.Sample(WetSampler_s, v5.zw).xyzw;
  r0.y = dot(r1.xx, WaveMovement);
  r0.xy = v5.xy + -r0.xy;
  r0.xy = WaveOffset + r0.xy;
  r0.zw = v5.xy + r0.xy;
  r2.xyzw = FoamSampler.Sample(FoamSampler_s, r0.xy).xyzw;
  r0.xyzw = WaterBumpSampler.Sample(WaterBumpSampler_s, r0.zw).xyzw;
  r0.x = r2.y * r0.x;
  r0.y = -WaterHeight + v1.z;
  r0.y = max(0, r0.y);
  r0.y = HeightOpacity * r0.y;
  r0.x = r0.x * r0.y;
  r0.x = v1.w * r0.x;
  r0.x = saturate(r0.x * r1.x);
  r0.x = globalScalars.x * r0.x;
  o0.w = r0.x;
  r0.y = -0.349999994 + v2.z;
  r0.y = saturate(1.53846157 * r0.y);
  r0.y = gDynamicBakesAndWetness.z * r0.y;
  r0.z = 1 + -globalScalars2.z;
  r0.y = r0.y * r0.z;
  r0.y = globalScalars.z * r0.y;
  o0.xyz = r0.yyy * float3(-0.5,-0.5,-0.5) + float3(1,1,1);
  r0.yz = float2(0.5,0.48828125) * r0.yy;
  o2.xy = sqrt(r0.yz);
  o1.w = r0.x;
  o2.w = r0.x;
  o1.xyz = v2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  o2.z = 0.980000019;
  o3.xyzw = float4(0,0,0,0);
  return;
}