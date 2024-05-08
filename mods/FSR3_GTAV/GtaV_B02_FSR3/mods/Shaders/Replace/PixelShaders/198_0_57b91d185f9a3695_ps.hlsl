// ---- FNV Hash 57b91d185f9a3695

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

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
  float specularFresnel : packoffset(c3.w);
  float specularFalloffMult : packoffset(c4);
  float specularIntensityMult : packoffset(c4.y);
  float3 specMapIntMask : packoffset(c5);
  float specTexTileUV : packoffset(c5.w);
  float4 specular2Color_DirLerp : packoffset(c6);
  float reflectivePower : packoffset(c7);
  float envEffThickness : packoffset(c7.y);
  float2 envEffScale : packoffset(c7.z);
  float envEffTexTileUV : packoffset(c8);
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
SamplerState DirtSampler_s : register(s5);
SamplerState SpecSampler_s : register(s6);
SamplerState DiffuseRampTextureSampler_s : register(s7);
SamplerState SpecularRampTextureSampler_s : register(s14);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> SnowSampler0 : register(t3);
Texture2D<float4> SnowSampler1 : register(t4);
Texture2D<float4> DirtSampler : register(t5);
Texture2D<float4> SpecSampler : register(t6);
Texture2D<float4> DiffuseRampTextureSampler : register(t7);
Texture2D<float4> SpecularRampTextureSampler : register(t14);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  linear sample float4 v1 : TEXCOORD0,
  linear sample float4 v2 : TEXCOORD1,
  linear sample float4 v3 : TEXCOORD2,
  linear sample float4 v4 : TEXCOORD3,
  linear sample float3 v5 : TEXCOORD6,
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

  r0.xy = specTexTileUV * v1.xy;
  r1.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r0.z = dot(v2.xyz, v2.xyz);
  r0.z = rsqrt(r0.z);
  r2.xyz = v2.xyz * r0.zzz;
  r3.xyzw = SpecSampler.Sample(SpecSampler_s, r0.xy).xyzw;
  r3.xy = r3.xy * r3.xy;
  r0.x = dot(r3.xyz, specMapIntMask.xyz);
  r0.y = dot(v4.xyz, v4.xyz);
  r0.y = rsqrt(r0.y);
  r3.xyz = v4.xyz * r0.yyy;
  r0.w = cmp(0 < matDiffuseSpecularRampEnabled);
  if (r0.w != 0) {
    r3.x = saturate(dot(r2.xyz, r3.xyz));
    r3.y = 0;
    r4.xyzw = DiffuseRampTextureSampler.Sample(DiffuseRampTextureSampler_s, r3.xy).xyzw;
  } else {
    r4.xyz = matDiffuseColor.xyz;
  }
  r1.xyz = r4.xyz * r1.xyz;
  r4.xyzw = v3.xxxw * r1.xyzw;
  r3.xy = globalScalars.zy * v3.xx;
  r0.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r5.y = r3.y * r0.w;
  r3.yz = envEffTexTileUV * v1.xy;
  r6.xyzw = SnowSampler0.Sample(SnowSampler0_s, r3.yz).xyzw;
  r7.xyzw = SnowSampler1.Sample(SnowSampler1_s, r3.yz).xyzw;
  r0.w = saturate(v5.z + v5.z);
  r1.w = -0.5 + v5.z;
  r1.w = saturate(r1.w + r1.w);
  r0.w = r0.w * r6.w;
  r1.xyz = -r1.xyz * v3.xxx + r6.xyz;
  r1.xyz = r0.www * r1.xyz + r4.xyz;
  r4.xyz = r7.xyz + -r1.xyz;
  r1.xyz = r1.www * r4.xyz + r1.xyz;
  r0.w = r0.x * specularIntensityMult + -specularIntensityMult;
  r0.w = v5.z * r0.w + specularIntensityMult;
  r1.w = r3.w * specularFalloffMult + -specularFalloffMult;
  r1.w = v5.z * r1.w + specularFalloffMult;
  r0.w = v3.x * r0.w;
  r0.w = v2.w * r0.w;
  r3.yz = float2(1,2) + -dirtLevelMod.zz;
  r2.w = v3.z * r3.y;
  r4.xy = v5.xy * r3.zz;
  r6.xyzw = DirtSampler.Sample(DirtSampler_s, r4.xy).xyzw;
  r3.z = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r4.x = r6.z + -r6.x;
  r6.x = r3.z * r4.x + r6.x;
  r4.xy = dirtLevelMod.xx * r6.xy;
  r3.z = v3.z * r3.y + -1;
  r3.y = r3.y * r3.z + 1;
  r3.z = r4.x * r3.y;
  r6.xyw = dirtColor.xyz * dirtLevelMod.yyy + -r1.xyz;
  r1.xyz = r3.zzz * r6.xyw + r1.xyz;
  r2.w = dirtLevelMod.x * r2.w;
  r6.xyz = r6.zzz + -r1.xyz;
  r1.xyz = r2.www * r6.xyz + r1.xyz;
  r2.w = -r4.y * r3.y + 1;
  r4.x = r2.w * r0.w;
  r3.y = dirtLevelMod.w * v3.x;
  r0.x = r3.y * r0.x;
  r0.x = 0.75 * r0.x;
  r6.xyz = float3(0,0,-1) + -gDirectionalLight.xyz;
  r6.xyz = specular2Color_DirLerp.www * r6.xyz + gDirectionalLight.xyz;
  r3.y = cmp(1.5 < abs(matDiffuseSpecularRampEnabled));
  if (r3.y != 0) {
    r7.x = saturate(dot(r2.xyz, -r6.xyz));
    r7.y = 0;
    r7.xyzw = SpecularRampTextureSampler.Sample(SpecularRampTextureSampler_s, r7.xy).xyzw;
  } else {
    r7.xyz = specular2Color_DirLerp.xyz;
  }
  r7.xyz = r7.xyz * r0.xxx;
  r6.xyz = v4.xyz * r0.yyy + -r6.xyz;
  r0.x = dot(r6.xyz, r6.xyz);
  r0.x = rsqrt(r0.x);
  r6.xyz = r6.xyz * r0.xxx;
  r0.x = dot(r2.xyz, r6.xyz);
  r0.x = saturate(9.99999994e-09 + r0.x);
  r0.y = r3.w * 15 + 9.99999994e-09;
  r0.x = log2(r0.x);
  r0.x = r0.y * r0.x;
  r0.x = exp2(r0.x);
  r1.xyz = r7.xyz * r0.xxx + r1.xyz;
  r1.xyz = min(float3(240,240,240), r1.xyz);
  r6.w = globalScalars.x * r4.w;
  r2.xyz = r2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r3.yzw = float3(256,256,256) * r2.xyz;
  r3.yzw = floor(r3.yzw);
  r2.xyz = r2.xyz * float3(256,256,256) + -r3.yzw;
  r2.xyz = float3(8,8,4) * r2.xyz;
  r2.xyz = floor(r2.xyz);
  r0.x = dot(r2.yxz, float3(4,32,1));
  o1.w = 0.00392156886 * r0.x;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r3.yzw;
  r4.y = 0.001953125 * r1.w;
  r5.x = v3.x * globalScalars.z + gLightArtificialIntAmbient0.w;
  r0.xy = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r0.xy);
  r0.x = v2.z * r0.z + -0.349999994;
  r0.x = saturate(1.53846204 * r0.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.y = 1 + -globalScalars2.z;
  r0.x = r0.x * r0.y;
  r0.x = r0.x * r3.x;
  r0.y = -r4.x * 0.5 + 1;
  r0.y = r0.x * r0.y;
  r0.y = r0.y * -0.5 + 1;
  r6.xyz = r1.xyz * r0.yyy;
  r0.y = saturate(r0.w * r2.w + 0.400000006);
  r4.z = specularFresnel;
  r1.xy = r0.yy * float2(0.5,0.48828131) + -r4.xy;
  r1.z = 0;
  r0.yzw = max(float3(0,0,0), r1.xyz);
  r0.xyz = r0.yzw * r0.xxx + r4.xyz;
  o2.xy = sqrt(r0.xy);
  r0.x = bDebugDisplayDamageMap | bDebugDisplayDamageScale;
  o0.xyzw = r0.xxxx ? v3.xyzw : r6.xyzw;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}