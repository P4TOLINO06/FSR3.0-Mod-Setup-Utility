// ---- FNV Hash 3efd83b6be01cc71

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

cbuffer vehicle_damage_locals : register(b12)
{
  float BoundRadius : packoffset(c0);
  float DamageMultiplier : packoffset(c0.y);
  float3 DamageTextureOffset : packoffset(c1);
  float4 DamagedWheelOffsets[2] : packoffset(c2);
  bool bDebugDisplayDamageMap : packoffset(c4);
  bool bDebugDisplayDamageScale : packoffset(c4.y);
}

cbuffer vehiclecommonlocals : register(b11)
{
  float3 matDiffuseColor : packoffset(c0);
  float4 matDiffuseColor2 : packoffset(c1);
  float4 dirtLevelMod : packoffset(c2);
  float3 dirtColor : packoffset(c3);
  float specularFresnel : packoffset(c3.w);
  float specularFalloffMult : packoffset(c4);
  float specularIntensityMult : packoffset(c4.y);
  float3 specMapIntMask : packoffset(c5);
  float reflectivePower : packoffset(c5.w);
  float envEffThickness : packoffset(c6);
  float2 envEffScale : packoffset(c6.y);
  float envEffTexTileUV : packoffset(c6.w);
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
SamplerState DirtSampler_s : register(s3);
SamplerState SpecSampler_s : register(s4);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> DirtSampler : register(t3);
Texture2D<float4> SpecSampler : register(t4);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float3 v4 : TEXCOORD3,
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

  r0.x = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r0.yz = float2(1,2) + -dirtLevelMod.zz;
  r0.zw = v1.xy * r0.zz;
  r1.xyzw = DirtSampler.Sample(DirtSampler_s, r0.zw).xyzw;
  r0.z = r1.z + -r1.x;
  r1.x = r0.x * r0.z + r1.x;
  r0.xz = dirtLevelMod.xx * r1.xy;
  r0.w = v3.z * r0.y + -1;
  r0.w = r0.y * r0.w + 1;
  r0.y = v3.z * r0.y;
  r0.y = dirtLevelMod.x * r0.y;
  r0.x = r0.x * r0.w;
  r0.z = -r0.z * r0.w + 1;
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r2.xyz = matDiffuseColor.xyz * r2.xyz;
  r2.xyzw = v3.xxxw * r2.xyzw;
  r1.xyw = dirtColor.xyz * dirtLevelMod.yyy + -r2.xyz;
  r1.xyw = r0.xxx * r1.xyw + r2.xyz;
  r2.w = globalScalars.x * r2.w;
  r3.xyz = r1.zzz + -r1.xyw;
  r0.xyw = r0.yyy * r3.xyz + r1.xyw;
  r1.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r1.xy = r1.xy * r1.xy;
  r1.w = specularFalloffMult * r1.w;
  r3.y = 0.001953125 * r1.w;
  r1.x = dot(r1.xyz, specMapIntMask.xyz);
  r1.x = specularIntensityMult * r1.x;
  r1.x = v3.x * r1.x;
  r1.x = v2.w * r1.x;
  r3.x = r1.x * r0.z;
  r0.z = saturate(r1.x * r0.z + 0.699999988);
  r1.xy = r0.zz * float2(0.5,0.48828125) + -r3.xy;
  r0.z = -r3.x * 0.5 + 1;
  r1.w = dot(v2.xyz, v2.xyz);
  r1.w = rsqrt(r1.w);
  r3.w = v2.z * r1.w + -0.349999994;
  r4.xyz = v2.xyz * r1.www;
  o1.xyz = r4.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r1.w = saturate(1.53846157 * r3.w);
  r1.w = gDynamicBakesAndWetness.z * r1.w;
  r3.w = 1 + -globalScalars2.z;
  r1.w = r3.w * r1.w;
  r3.w = globalScalars.z * v3.x;
  r1.w = r3.w * r1.w;
  r0.z = r1.w * r0.z;
  r0.z = r0.z * -0.5 + 1;
  r2.xyz = r0.xyw * r0.zzz;
  r0.x = bDebugDisplayDamageMap | bDebugDisplayDamageScale;
  o0.xyzw = r0.xxxx ? v3.xyzw : r2.xyzw;
  o1.w = r2.w;
  o2.w = r2.w;
  r1.z = 0;
  r0.xyz = max(float3(0,0,0), r1.xyz);
  r3.z = specularFresnel;
  r0.xyz = r0.xyz * r1.www + r3.xyz;
  o2.xy = sqrt(r0.xy);
  o2.z = r0.z;
  o3.xyzw = float4(0,0,0,1);
  return;
}