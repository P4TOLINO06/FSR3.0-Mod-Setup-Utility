// ---- FNV Hash d106341ce6cc0015

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
  float3 dirtDecalMask : packoffset(c0);
  float specularFresnel : packoffset(c0.w);
  float specularFalloffMult : packoffset(c1);
  float specularIntensityMult : packoffset(c1.y);
  float useTessellation : packoffset(c1.z);
  float HardAlphaBlend : packoffset(c1.w);
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

SamplerState DiffuseSampler_s : register(s0);
Texture2D<float4> DiffuseSampler : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
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

  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v2.xy).xyzw;
  r0.w = dot(r0.xyz, dirtDecalMask.xyz);
  r0.xyz = float3(1,1,1);
  r0.xyzw = v1.xyzw * r0.xyzw;
  r1.x = -specularIntensityMult * 0.5 + 1;
  r1.y = 1 + -globalScalars2.z;
  r1.y = gDynamicBakesAndWetness.z * r1.y;
  r1.y = globalScalars.z * r1.y;
  r1.x = r1.y * r1.x;
  r1.x = r1.x * -0.5 + 1;
  o0.xyz = r1.xxx * r0.xyz;
  r0.x = globalScalars.x * r0.w;
  o0.w = r0.x;
  o2.w = r0.x;
  o1.xyzw = float4(0,0,0,0);
  r0.x = saturate(0.699999988 + specularIntensityMult);
  r0.xy = float2(0.5,0.48828125) * r0.xx;
  r2.y = -specularIntensityMult;
  r2.w = -specularFresnel;
  r0.z = 0.970000029;
  r0.w = 0.001953125 * specularFalloffMult;
  r2.z = -r0.w;
  r0.xyz = r2.yzw + r0.xyz;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r2.y = r0.y * r1.y + r0.w;
  r2.x = r0.x * r1.y + specularIntensityMult;
  o2.z = r0.z * r1.y + specularFresnel;
  o2.xy = sqrt(r2.xy);
  o3.xyzw = float4(0,0,0,0);
  return;
}