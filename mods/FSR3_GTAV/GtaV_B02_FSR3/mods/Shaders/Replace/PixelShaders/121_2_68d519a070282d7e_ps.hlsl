// ---- FNV Hash 68d519a070282d7e

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 21:49:06 2023

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
  float emissiveMultiplier : packoffset(c2);
  float4 dirtLevelMod : packoffset(c3);
  float3 dirtColor : packoffset(c4);
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
  r0.zw = v1.zw * r0.zz;
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
  r0.w = -globalScalars2.y * 100 + 1;
  r0.x = saturate(r0.x * r0.w);
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.xyw = matDiffuseColor.xyz * r2.xyz;
  r0.w = v3.w * r2.w;
  r0.w = globalScalars.x * r0.w;
  r2.w = globalScalars2.y * r0.w;
  r3.xyz = dirtColor.xyz * dirtLevelMod.yyy + -r1.xyw;
  r1.xyw = r0.xxx * r3.xyz + r1.xyw;
  r3.xyz = r1.zzz + -r1.xyw;
  r0.xyw = r0.yyy * r3.xyz + r1.xyw;
  r1.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r1.xy = r1.xy * r1.xy;
  r3.y = 0.99609375 * r1.w;
  r1.x = dot(r1.xyz, specMapIntMask.xyz);
  r1.x = v3.x * r1.x;
  r1.x = v2.w * r1.x;
  r1.x = 0.800000012 * r1.x;
  r3.x = r1.x * r0.z;
  r0.z = saturate(r1.x * r0.z + 0.400000006);
  r1.xy = r0.zz * float2(0.5,0.48828125) + -r3.xy;
  r1.xy = max(float2(0,0), r1.xy);
  r0.z = -r3.x * 0.5 + 1;
  r1.z = dot(v2.xyz, v2.xyz);
  r1.z = rsqrt(r1.z);
  r1.w = v2.z * r1.z + -0.349999994;
  r4.xyz = v2.xyz * r1.zzz;
  o1.xyz = r4.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r1.z = saturate(1.53846157 * r1.w);
  r1.z = gDynamicBakesAndWetness.z * r1.z;
  r1.w = 1 + -globalScalars2.z;
  r1.z = r1.z * r1.w;
  r1.z = globalScalars.z * r1.z;
  r0.z = r1.z * r0.z;
  r1.xy = r1.xy * r1.zz + r3.xy;
  o2.xy = sqrt(r1.xy);
  r0.z = r0.z * -0.5 + 1;
  r2.xyz = r0.xyw * r0.zzz;
  r0.x = bDebugDisplayDamageMap | bDebugDisplayDamageScale;
  o0.xyzw = r0.xxxx ? v3.xyzw : r2.xyzw;
  o1.w = 0;
  o2.zw = float2(0.959999979,1);
  r0.x = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r0.y = globalScalars.y * r0.x;
  r0.x = gLightArtificialIntAmbient0.w + globalScalars.z;
  r0.xy = float2(0.5,0.5) * r0.xy;
  o3.xy = sqrt(r0.xy);
  r0.x = emissiveMultiplier * v3.x;
  r0.x = dirtLevelMod.z * r0.x;
  o3.z = saturate(0.0625 * r0.x);
  o3.w = 1.00188386;
  return;
}