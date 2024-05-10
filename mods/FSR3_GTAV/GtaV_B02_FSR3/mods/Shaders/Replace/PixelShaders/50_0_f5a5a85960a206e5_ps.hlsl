// ---- FNV Hash f5a5a85960a206e5

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
  float matDiffuseSpecularRampEnabled : packoffset(c0.w);
  float4 matDiffuseColor2 : packoffset(c1);
  float4 dirtLevelMod : packoffset(c2);
  float3 dirtColor : packoffset(c3);
  float4 specular2Color_DirLerp : packoffset(c4);
  float reflectivePower : packoffset(c5);
  float envEffThickness : packoffset(c5.y);
  float2 envEffScale : packoffset(c5.z);
  float envEffTexTileUV : packoffset(c6);
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
SamplerState BumpSampler_s : register(s4);
SamplerState SpecSampler_s : register(s5);
SamplerState DiffuseRampTextureSampler_s : register(s6);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> DirtSampler : register(t3);
Texture2D<float4> BumpSampler : register(t4);
Texture2D<float4> SpecSampler : register(t5);
Texture2D<float4> DiffuseRampTextureSampler : register(t6);


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
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.xyzw = BumpSampler.Sample(BumpSampler_s, v1.xy).xyzw;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r1.xy, r1.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r2.xyz = v6.xyz * r1.yyy;
  r1.xyw = r1.xxx * v5.xyz + r2.xyz;
  r1.xyz = r1.zzz * v2.xyz + r1.xyw;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r1.xyz * r1.www;
  r3.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r1.xy = r3.xy * r3.xy;
  r3.w = 1 + -r3.z;
  r2.w = v3.x * r1.x;
  r4.x = dot(v4.xyz, v4.xyz);
  r4.x = rsqrt(r4.x);
  r4.yzw = v4.xyz * r4.xxx;
  r5.x = cmp(0 < matDiffuseSpecularRampEnabled);
  if (r5.x != 0) {
    r5.x = saturate(dot(r2.xyz, r4.yzw));
    r5.y = 0;
    r5.xyzw = DiffuseRampTextureSampler.Sample(DiffuseRampTextureSampler_s, r5.xy).xyzw;
  } else {
    r5.xyz = matDiffuseColor.xyz;
  }
  r0.xyz = r5.xyz * r0.xyz;
  r0.xyzw = v3.xxxw * r0.xyzw;
  r4.yz = globalScalars.zy * v3.xx;
  r4.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r5.y = r4.z * r4.w;
  r2.w = v2.w * r2.w;
  r2.w = 0.600000024 * r2.w;
  r4.zw = float2(1,2) + -dirtLevelMod.zz;
  r5.z = v3.z * r4.z;
  r6.xy = v1.zw * r4.ww;
  r6.xyzw = DirtSampler.Sample(DirtSampler_s, r6.xy).xyzw;
  r4.w = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r5.w = r6.z + -r6.x;
  r6.x = r4.w * r5.w + r6.x;
  r6.xy = dirtLevelMod.xx * r6.xy;
  r4.w = v3.z * r4.z + -1;
  r4.z = r4.z * r4.w + 1;
  r4.w = r6.x * r4.z;
  r7.xyz = dirtColor.xyz * dirtLevelMod.yyy + -r0.xyz;
  r0.xyz = r4.www * r7.xyz + r0.xyz;
  r4.w = dirtLevelMod.x * r5.z;
  r6.xzw = r6.zzz + -r0.xyz;
  r0.xyz = r4.www * r6.xzw + r0.xyz;
  r4.z = -r6.y * r4.z + 1;
  r3.x = r4.z * r2.w;
  r2.w = dirtLevelMod.w * v3.x;
  r1.x = r2.w * r1.x;
  r1.x = 0.600000024 * r1.x;
  r3.yz = float2(20,0.8984375) * r1.yy;
  r6.xyz = float3(0,0,-1) + -gDirectionalLight.xyz;
  r6.xyz = specular2Color_DirLerp.www * r6.xyz + gDirectionalLight.xyz;
  r4.xzw = v4.xyz * r4.xxx + -r6.xyz;
  r1.y = dot(r4.xzw, r4.xzw);
  r1.y = rsqrt(r1.y);
  r4.xzw = r4.xzw * r1.yyy;
  r1.y = dot(r2.xyz, r4.xzw);
  r1.y = saturate(9.99999994e-09 + r1.y);
  r4.xz = float2(0.400000006,9.99999994e-09) + r3.xy;
  r1.y = log2(r1.y);
  r1.y = r4.z * r1.y;
  r1.y = exp2(r1.y);
  r0.xyz = r1.xxx * r1.yyy + r0.xyz;
  r6.w = globalScalars.x * r0.w;
  r2.xyz = r2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r7.xyz = float3(256,256,256) * r2.xyz;
  r7.xyz = floor(r7.xyz);
  r2.xyz = r2.xyz * float3(256,256,256) + -r7.xyz;
  r2.xyz = float3(8,8,4) * r2.xyz;
  r2.xyz = floor(r2.xyz);
  r0.w = dot(r2.yxz, float3(4,32,1));
  o1.w = 0.00392156886 * r0.w;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r7.xyz;
  r5.x = v3.x * globalScalars.z + gLightArtificialIntAmbient0.w;
  r1.xy = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r1.xy);
  r0.w = r1.z * r1.w + -0.349999994;
  r0.w = saturate(1.53846157 * r0.w);
  r0.w = gDynamicBakesAndWetness.z * r0.w;
  r1.x = 1 + -globalScalars2.z;
  r0.w = r1.x * r0.w;
  r0.w = r0.w * r4.y;
  r1.x = -r3.x * 0.5 + 1;
  r1.x = r1.x * r0.w;
  r1.x = r1.x * -0.5 + 1;
  r6.xyz = r1.xxx * r0.xyz;
  r4.x = saturate(r4.x);
  r0.xy = r4.xx * float2(0.5,0.48828125) + -r3.xz;
  r0.z = 0;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r0.xyz = r0.xyz * r0.www + r3.xzw;
  o2.xy = sqrt(r0.xy);
  r0.x = bDebugDisplayDamageMap | bDebugDisplayDamageScale;
  o0.xyzw = r0.xxxx ? v3.xyzw : r6.xyzw;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188386);
  return;
}