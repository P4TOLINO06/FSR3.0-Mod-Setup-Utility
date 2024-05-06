// ---- FNV Hash 6b4b30f8dd2c7310

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
  float specularFresnel : packoffset(c0);
  float specularFalloffMult : packoffset(c0.y);
  float specularIntensityMult : packoffset(c0.z);
  float3 specMapIntMask : packoffset(c1);
  float bumpiness : packoffset(c1.w);
  float wetnessMultiplier : packoffset(c2);
  float useTessellation : packoffset(c2.y);
  float HardAlphaBlend : packoffset(c2.z);
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
SamplerState BumpSampler_s : register(s3);
SamplerState SpecSampler_s : register(s4);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> BumpSampler : register(t3);
Texture2D<float4> SpecSampler : register(t4);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : COLOR0,
  float4 v2 : COLOR1,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
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
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = max(0.00100000005, bumpiness);
  r1.xyzw = BumpSampler.Sample(BumpSampler_s, v3.xy).xyzw;
  r0.yz = r1.xy * float2(2,2) + float2(-1,-1);
  r0.xw = r0.yz * r0.xx;
  r0.y = dot(r0.yz, r0.yz);
  r0.y = 1 + -r0.y;
  r0.y = sqrt(abs(r0.y));
  r1.xyz = v6.xyz * r0.www;
  r0.xzw = r0.xxx * v5.xyz + r1.xyz;
  r0.xyz = r0.yyy * v4.xyz + r0.xzw;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r1.x = r0.z * r0.w + -0.349999994;
  r0.xyz = r0.xyz * r0.www;
  o1.xyz = r0.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.x = saturate(1.53846157 * r1.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.y = 1 + -globalScalars2.z;
  r0.x = r0.x * r0.y;
  r0.y = globalScalars.z * v1.x;
  r0.x = r0.x * r0.y;
  r1.xyzw = SpecSampler.Sample(SpecSampler_s, v3.xy).xyzw;
  r1.xy = r1.xy * r1.xy;
  r0.y = specularFalloffMult * r1.w;
  r2.y = 0.001953125 * r0.y;
  r0.y = dot(r1.xyz, specMapIntMask.xyz);
  r2.x = specularIntensityMult * r0.y;
  r0.y = saturate(r0.y * specularIntensityMult + 0.699999988);
  r1.xy = float2(0.5,0.48828125) * r0.yy;
  r0.y = -r2.x * 0.5 + 1;
  r0.y = r0.x * r0.y;
  r0.x = wetnessMultiplier * r0.x;
  r0.y = r0.y * -0.5 + 1;
  r3.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v3.xy).xyzw;
  r3.xyz = v2.xyz * r3.xyz;
  r0.z = v1.w * r3.w;
  r0.z = globalScalars.x * r0.z;
  o0.xyz = r3.xyz * r0.yyy;
  o0.w = r0.z;
  o1.w = r0.z;
  o2.w = r0.z;
  r1.z = 0.970000029;
  r2.z = specularFresnel;
  r0.yzw = -r2.xyz + r1.xyz;
  r0.yzw = max(float3(0,0,0), r0.yzw);
  r0.xyz = r0.yzw * r0.xxx + r2.xyz;
  o2.xy = sqrt(r0.xy);
  o2.z = r0.z;
  o3.xyzw = float4(0,0,0,1);
  return;
}