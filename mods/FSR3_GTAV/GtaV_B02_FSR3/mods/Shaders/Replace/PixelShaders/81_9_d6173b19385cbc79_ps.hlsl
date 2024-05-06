// ---- FNV Hash d6173b19385cbc79

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
  float DiffuseTexTileUV : packoffset(c0);
  float3 matDiffuseColor : packoffset(c0.y);
  float matDiffuseSpecularRampEnabled : packoffset(c1);
  float4 matDiffuseColor2 : packoffset(c2);
  float4 dirtLevelMod : packoffset(c3);
  float3 dirtColor : packoffset(c4);
  float specularFresnel : packoffset(c4.w);
  float specularFalloffMult : packoffset(c5);
  float specularIntensityMult : packoffset(c5.y);
  float3 specMapIntMask : packoffset(c6);
  float specTexTileUV : packoffset(c6.w);
  float specular2Factor : packoffset(c7);
  float specular2ColorIntensity : packoffset(c7.y);
  float4 specular2Color_DirLerp : packoffset(c8);
  float reflectivePower : packoffset(c9);
  float diffuse2SpecMod : packoffset(c9.y);
  float envEffThickness : packoffset(c9.z);
  float2 envEffScale : packoffset(c10);
  float envEffTexTileUV : packoffset(c10.z);
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
SamplerState DiffuseSampler2_s : register(s3);
SamplerState DirtSampler_s : register(s4);
SamplerState SpecSampler_s : register(s5);
SamplerState DiffuseRampTextureSampler_s : register(s6);
SamplerState SpecularRampTextureSampler_s : register(s14);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> DiffuseSampler2 : register(t3);
Texture2D<float4> DirtSampler : register(t4);
Texture2D<float4> SpecSampler : register(t5);
Texture2D<float4> DiffuseRampTextureSampler : register(t6);
Texture2D<float4> SpecularRampTextureSampler : register(t14);


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
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)v0.xy;
  r0.xy = (int2)r0.xy & int2(1,1);
  r0.y = (uint)r0.y << 1;
  r0.x = (int)r0.x + (int)r0.y;
  r0.x = dot(globalFade.xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.xy = DiffuseTexTileUV * v1.xy;
  r0.zw = specTexTileUV * v1.xy;
  r1.xyzw = DiffuseSampler2.Sample(DiffuseSampler2_s, v1.zw).xyzw;
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, r0.xy).xyzw;
  r0.x = dot(v2.xyz, v2.xyz);
  r0.x = rsqrt(r0.x);
  r3.xyz = v2.xyz * r0.xxx;
  r4.xyzw = SpecSampler.Sample(SpecSampler_s, r0.zw).xyzw;
  r4.xy = r4.xy * r4.xy;
  r0.y = dot(r4.xyz, specMapIntMask.xyz);
  r0.z = specularIntensityMult * r0.y;
  r0.w = dot(v4.xyz, v4.xyz);
  r0.w = rsqrt(r0.w);
  r4.xyz = v4.xyz * r0.www;
  r3.w = cmp(0 < matDiffuseSpecularRampEnabled);
  if (r3.w != 0) {
    r4.x = saturate(dot(r3.xyz, r4.xyz));
    r4.y = 0;
    r5.xyzw = DiffuseRampTextureSampler.Sample(DiffuseRampTextureSampler_s, r4.xy).xyzw;
  } else {
    r5.xyz = matDiffuseColor.xyz;
  }
  r4.xyz = r5.xyz * r2.xyz;
  r1.w = matDiffuseColor2.w * r1.w;
  r1.xyz = r1.xyz * matDiffuseColor2.xyz + -r4.xyz;
  r2.xyz = r1.www * r1.xyz + r4.xyz;
  r1.xyzw = v3.xxxw * r2.xyzw;
  r2.x = globalScalars.z * v3.x;
  r0.z = v3.x * r0.z;
  r0.z = v2.w * r0.z;
  r2.yz = float2(1,2) + -dirtLevelMod.zz;
  r2.w = v3.z * r2.y;
  r4.xy = v1.xy * r2.zz;
  r5.xyzw = DirtSampler.Sample(DirtSampler_s, r4.xy).xyzw;
  r2.z = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r3.w = r5.z + -r5.x;
  r5.x = r2.z * r3.w + r5.x;
  r4.xy = dirtLevelMod.xx * r5.xy;
  r2.z = v3.z * r2.y + -1;
  r2.y = r2.y * r2.z + 1;
  r2.z = r4.x * r2.y;
  r5.xyw = dirtColor.xyz * dirtLevelMod.yyy + -r1.xyz;
  r1.xyz = r2.zzz * r5.xyw + r1.xyz;
  r2.z = dirtLevelMod.x * r2.w;
  r5.xyz = r5.zzz + -r1.xyz;
  r1.xyz = r2.zzz * r5.xyz + r1.xyz;
  r2.y = -r4.y * r2.y + 1;
  r0.z = r2.y * r0.z;
  r2.y = cmp(0 < specular2ColorIntensity);
  if (r2.y != 0) {
    r2.y = specular2ColorIntensity * dirtLevelMod.w;
    r2.y = v3.x * r2.y;
    r0.y = r2.y * r0.y;
    r2.yzw = float3(0,0,-1) + -gDirectionalLight.xyz;
    r2.yzw = specular2Color_DirLerp.www * r2.yzw + gDirectionalLight.xyz;
    r3.w = cmp(1.5 < abs(matDiffuseSpecularRampEnabled));
    if (r3.w != 0) {
      r4.x = saturate(dot(r3.xyz, -r2.yzw));
      r4.y = 0;
      r5.xyzw = SpecularRampTextureSampler.Sample(SpecularRampTextureSampler_s, r4.xy).xyzw;
    } else {
      r5.xyz = specular2Color_DirLerp.xyz;
    }
    r4.xyz = r5.xyz * r0.yyy;
    r2.yzw = v4.xyz * r0.www + -r2.yzw;
    r0.y = dot(r2.yzw, r2.yzw);
    r0.y = rsqrt(r0.y);
    r2.yzw = r2.yzw * r0.yyy;
    r0.y = dot(r3.xyz, r2.yzw);
    r0.y = saturate(9.99999994e-09 + r0.y);
    r0.w = specular2Factor * r4.w + 9.99999994e-09;
    r0.y = log2(r0.y);
    r0.y = r0.w * r0.y;
    r0.y = exp2(r0.y);
    r1.xyz = r4.xyz * r0.yyy + r1.xyz;
  }
  r1.xyz = min(float3(240,240,240), r1.xyz);
  r3.w = globalScalars.x * r1.w;
  r0.x = v2.z * r0.x + -0.349999994;
  r0.x = saturate(1.53846157 * r0.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.y = 1 + -globalScalars2.z;
  r0.x = r0.x * r0.y;
  r0.x = r0.x * r2.x;
  r0.y = -r0.z * 0.5 + 1;
  r0.x = r0.x * r0.y;
  r0.x = r0.x * -0.5 + 1;
  r3.xyz = r1.xyz * r0.xxx;
  r0.x = bDebugDisplayDamageMap | bDebugDisplayDamageScale;
  r0.xyzw = r0.xxxx ? v3.xyzw : r3.xyzw;
  r1.x = cmp(0.00392156886 >= r0.w);
  if (r1.x != 0) discard;
  o0.xyzw = r0.xyzw;
  return;
}