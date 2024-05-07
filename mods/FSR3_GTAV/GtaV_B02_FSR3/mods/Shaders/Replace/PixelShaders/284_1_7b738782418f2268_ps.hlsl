// ---- FNV Hash 447be8af210811be

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
SamplerState SnowSampler0_s : register(s3);
SamplerState SnowSampler1_s : register(s4);
SamplerState DiffuseSampler2_s : register(s5);
SamplerState DirtSampler_s : register(s6);
SamplerState SpecSampler_s : register(s7);
SamplerState DiffuseRampTextureSampler_s : register(s8);
SamplerState SpecularRampTextureSampler_s : register(s14);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> SnowSampler0 : register(t3);
Texture2D<float4> SnowSampler1 : register(t4);
Texture2D<float4> DiffuseSampler2 : register(t5);
Texture2D<float4> DirtSampler : register(t6);
Texture2D<float4> SpecSampler : register(t7);
Texture2D<float4> DiffuseRampTextureSampler : register(t8);
Texture2D<float4> SpecularRampTextureSampler : register(t14);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
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
  r0.w = specularFalloffMult * r4.w;
  r3.w = dot(v4.xyz, v4.xyz);
  r3.w = rsqrt(r3.w);
  r4.xyz = v4.xyz * r3.www;
  r5.x = cmp(0 < matDiffuseSpecularRampEnabled);
  if (r5.x != 0) {
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
  r4.xy = globalScalars.zy * v3.xx;
  r2.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r5.y = r4.y * r2.w;
  r4.yz = envEffTexTileUV * v1.xy;
  r6.xyzw = SnowSampler0.Sample(SnowSampler0_s, r4.yz).xyzw;
  r7.xyzw = SnowSampler1.Sample(SnowSampler1_s, r4.yz).xyzw;
  r2.w = saturate(v4.w + v4.w);
  r4.y = -0.5 + v4.w;
  r4.y = saturate(r4.y + r4.y);
  r2.w = r2.w * r6.w;
  r2.xyz = -r2.xyz * v3.xxx + r6.xyz;
  r1.xyz = r2.www * r2.xyz + r1.xyz;
  r2.xyz = r7.xyz + -r1.xyz;
  r1.xyz = r4.yyy * r2.xyz + r1.xyz;
  r0.z = v3.x * r0.z;
  r0.z = v2.w * r0.z;
  r2.xy = float2(1,2) + -dirtLevelMod.zz;
  r2.z = v3.z * r2.x;
  r2.yw = v1.xy * r2.yy;
  r6.xyzw = DirtSampler.Sample(DirtSampler_s, r2.yw).xyzw;
  r2.y = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r2.w = r6.z + -r6.x;
  r6.x = r2.y * r2.w + r6.x;
  r2.yw = dirtLevelMod.xx * r6.xy;
  r4.y = v3.z * r2.x + -1;
  r2.x = r2.x * r4.y + 1;
  r2.y = r2.y * r2.x;
  r6.xyw = dirtColor.xyz * dirtLevelMod.yyy + -r1.xyz;
  r1.xyz = r2.yyy * r6.xyw + r1.xyz;
  r2.y = dirtLevelMod.x * r2.z;
  r6.xyz = r6.zzz + -r1.xyz;
  r1.xyz = r2.yyy * r6.xyz + r1.xyz;
  r2.x = -r2.w * r2.x + 1;
  r6.x = r2.x * r0.z;
  r2.y = cmp(0 < specular2ColorIntensity);
  if (r2.y != 0) {
    r2.y = specular2ColorIntensity * dirtLevelMod.w;
    r2.y = v3.x * r2.y;
    r0.y = r2.y * r0.y;
    r2.yzw = float3(0,0,-1) + -gDirectionalLight.xyz;
    r2.yzw = specular2Color_DirLerp.www * r2.yzw + gDirectionalLight.xyz;
    r4.y = cmp(1.5 < abs(matDiffuseSpecularRampEnabled));
    if (r4.y != 0) {
      r7.x = saturate(dot(r3.xyz, -r2.yzw));
      r7.y = 0;
      r7.xyzw = SpecularRampTextureSampler.Sample(SpecularRampTextureSampler_s, r7.xy).xyzw;
    } else {
      r7.xyz = specular2Color_DirLerp.xyz;
    }
    r7.xyz = r7.xyz * r0.yyy;
    r2.yzw = v4.xyz * r3.www + -r2.yzw;
    r0.y = dot(r2.yzw, r2.yzw);
    r0.y = rsqrt(r0.y);
    r2.yzw = r2.yzw * r0.yyy;
    r0.y = dot(r3.xyz, r2.yzw);
    r0.y = saturate(9.99999994e-09 + r0.y);
    r2.y = specular2Factor * r4.w + 9.99999994e-09;
    r0.y = log2(r0.y);
    r0.y = r2.y * r0.y;
    r0.y = exp2(r0.y);
    r1.xyz = r7.xyz * r0.yyy + r1.xyz;
  }
  r1.xyz = min(float3(240,240,240), r1.xyz);
  r7.w = globalScalars.x * r1.w;
  r2.yzw = r3.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r3.xyz = float3(256,256,256) * r2.yzw;
  r3.xyz = floor(r3.xyz);
  r2.yzw = r2.yzw * float3(256,256,256) + -r3.xyz;
  r2.yzw = float3(8,8,4) * r2.yzw;
  r2.yzw = floor(r2.yzw);
  r0.y = dot(r2.yzw, float3(32,4,1));
  o1.w = 0.00392156886 * r0.y;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r3.xyz;
  r6.y = 0.001953125 * r0.w;
  r5.x = v3.x * globalScalars.z + gLightArtificialIntAmbient0.w;
  r0.yw = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r0.yw);
  r0.x = v2.z * r0.x + -0.349999994;
  r0.x = saturate(1.53846157 * r0.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.y = 1 + -globalScalars2.z;
  r0.x = r0.x * r0.y;
  r0.x = r0.x * r4.x;
  r0.y = -r6.x * 0.5 + 1;
  r0.y = r0.x * r0.y;
  r0.y = r0.y * -0.5 + 1;
  r7.xyz = r1.xyz * r0.yyy;
  r0.y = saturate(r0.z * r2.x + 0.400000006);
  r6.z = specularFresnel;
  r1.xy = r0.yy * float2(0.5,0.48828125) + -r6.xy;
  r1.z = 0;
  r0.yzw = max(float3(0,0,0), r1.xyz);
  r0.xyz = r0.yzw * r0.xxx + r6.xyz;
  o2.xy = sqrt(r0.xy);
  r0.x = bDebugDisplayDamageMap | bDebugDisplayDamageScale;
  o0.xyzw = r0.xxxx ? v3.xyzw : r7.xyzw;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188386);
  return;
}