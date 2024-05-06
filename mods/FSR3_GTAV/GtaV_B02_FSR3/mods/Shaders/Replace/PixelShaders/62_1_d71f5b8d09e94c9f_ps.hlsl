// ---- FNV Hash d71f5b8d09e94c9f

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
  float bumpiness : packoffset(c0.w);
  float useTessellation : packoffset(c1);
  float HardAlphaBlend : packoffset(c1.y);
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
SamplerState BumpSampler_s : register(s2);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> BumpSampler : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD4,
  float3 v5 : TEXCOORD5,
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
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)v0.xy;
  r0.xy = (int2)r0.xy & int2(1,1);
  r0.y = (uint)r0.y << 1;
  r0.x = (int)r0.x + (int)r0.y;
  r0.x = dot(globalFade.xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v2.xy).xyzw;
  r0.x = globalScalars.x * r0.w;
  r0.x = cmp(gAlphaRefVec0.x >= r0.x);
  if (r0.x != 0) discard;
  r0.xyzw = BumpSampler.Sample(BumpSampler_s, v2.xy).xyzw;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.z = dot(r0.xy, r0.xy);
  r0.z = 1 + -r0.z;
  r0.z = sqrt(abs(r0.z));
  r1.x = max(0.00100000005, bumpiness);
  r0.xy = r1.xx * r0.xy;
  r1.xyz = v5.xyz * r0.yyy;
  r1.xyz = r0.xxx * v4.xyz + r1.xyz;
  r0.xyz = r0.zzz * v3.xyz + r1.xyz;
  r1.x = dot(r0.xyz, r0.xyz);
  r1.x = rsqrt(r1.x);
  r1.yzw = r1.xxx * r0.xyz;
  r0.x = globalScalars.z * v1.x;
  o1.xyz = r1.yzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.y = v1.w * r0.w;
  o1.w = globalScalars.x * r0.y;
  r0.y = r0.z * r1.x + -0.349999994;
  r0.y = saturate(1.53846157 * r0.y);
  r0.y = gDynamicBakesAndWetness.z * r0.y;
  r0.z = 1 + -globalScalars2.z;
  r0.y = r0.y * r0.z;
  r0.z = r0.y * r0.x;
  r0.w = saturate(0.699999988 + specularIntensityMult);
  r0.xy = r0.zz * r0.ww;
  r0.xyz = float3(0.5,0.48828125,0.970000029) * r0.xyz;
  o2.xy = sqrt(r0.xy);
  o2.z = r0.z;
  o2.w = 0;
  o0.xyzw = float4(0,0,0,0);
  o3.xyzw = float4(0,0,0,0);
  return;
}