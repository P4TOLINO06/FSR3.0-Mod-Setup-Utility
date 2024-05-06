// ---- FNV Hash fa5ab169684d9f16

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

cbuffer terrain_cb_common_locals : register(b12)
{
  float specularFalloffMult : packoffset(c0);
  float specularIntensityMult : packoffset(c0.y);
  float bumpiness : packoffset(c0.z);
  float bumpSelfShadowAmount : packoffset(c0.w);
  float4 materialWetnessMultiplier : packoffset(c1);
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

SamplerState TextureSampler_layer0_s : register(s3);
SamplerState BumpSampler_layer0_s : register(s4);
SamplerState TextureSampler_layer1_s : register(s5);
SamplerState BumpSampler_layer1_s : register(s6);
SamplerState TextureSampler_layer2_s : register(s7);
SamplerState BumpSampler_layer2_s : register(s8);
SamplerState TextureSampler_layer3_s : register(s9);
SamplerState BumpSampler_layer3_s : register(s10);
SamplerState lookupSampler_s : register(s11);
Texture2D<float4> TextureSampler_layer0 : register(t3);
Texture2D<float4> BumpSampler_layer0 : register(t4);
Texture2D<float4> TextureSampler_layer1 : register(t5);
Texture2D<float4> BumpSampler_layer1 : register(t6);
Texture2D<float4> TextureSampler_layer2 : register(t7);
Texture2D<float4> BumpSampler_layer2 : register(t8);
Texture2D<float4> TextureSampler_layer3 : register(t9);
Texture2D<float4> BumpSampler_layer3 : register(t10);
Texture2D<float4> lookupSampler : register(t11);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : COLOR1,
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
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)v0.xy;
  r0.xy = (int2)r0.xy & int2(1,1);
  r0.y = (uint)r0.y << 1;
  r0.x = (int)r0.x + (int)r0.y;
  r0.x = dot(globalFade.xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.xyzw = lookupSampler.Sample(lookupSampler_s, v1.zw).xyzw;
  r1.xyz = saturate(r0.xyz);
  r2.xyz = float3(1,1,1) + -r1.xyz;
  r0.w = r2.x * r2.y;
  r1.x = r0.w * r2.z;
  r0.w = r0.w * r1.z;
  r1.y = r2.x * r1.y;
  r1.w = r1.y * r2.z;
  r1.y = r1.y * r1.z;
  r2.xyzw = TextureSampler_layer0.Sample(TextureSampler_layer0_s, v1.xy).xyzw;
  r3.xyzw = TextureSampler_layer1.Sample(TextureSampler_layer1_s, v1.xy).xyzw;
  r3.xyz = r3.xyz * r0.www;
  r2.xyz = r2.xyz * r1.xxx + r3.xyz;
  r3.xyzw = TextureSampler_layer2.Sample(TextureSampler_layer2_s, v1.xy).xyzw;
  r1.xzw = r3.xyz * r1.www + r2.xyz;
  r2.xyzw = TextureSampler_layer3.Sample(TextureSampler_layer3_s, v1.xy).xyzw;
  r1.xyz = r2.xyz * r1.yyy + r1.xzw;
  r2.xyz = float3(1,1,1) + -r0.xyz;
  r0.x = r2.x * r2.y;
  r0.w = r0.x * r2.z;
  r0.y = r2.x * r0.y;
  r1.w = r0.y * r2.z;
  r0.xy = r0.xy * r0.zz;
  r2.xyzw = BumpSampler_layer0.Sample(BumpSampler_layer0_s, v1.xy).xyzw;
  r3.xyzw = BumpSampler_layer1.Sample(BumpSampler_layer1_s, v1.xy).xyzw;
  r2.zw = r3.xy * r0.xx;
  r2.xy = r2.xy * r0.ww + r2.zw;
  r3.xyzw = BumpSampler_layer2.Sample(BumpSampler_layer2_s, v1.xy).xyzw;
  r2.xy = r3.xy * r1.ww + r2.xy;
  r3.xyzw = BumpSampler_layer3.Sample(BumpSampler_layer3_s, v1.xy).xyzw;
  r2.xy = r3.xy * r0.yy + r2.xy;
  r2.xy = r2.xy * float2(2,2) + float2(-1,-1);
  r0.z = dot(r2.xy, r2.xy);
  r0.z = 1 + -r0.z;
  r0.z = sqrt(abs(r0.z));
  r2.z = max(0.00100000005, bumpiness);
  r2.xy = r2.xy * r2.zz;
  r2.yzw = v6.xyz * r2.yyy;
  r2.xyz = r2.xxx * v5.xyz + r2.yzw;
  r2.xyz = r0.zzz * v3.xyz + r2.xyz;
  r0.z = dot(r2.xyz, r2.xyz);
  r0.z = rsqrt(r0.z);
  r2.xyw = r2.xyz * r0.zzz;
  r0.x = materialWetnessMultiplier.y * r0.x;
  r0.x = materialWetnessMultiplier.x * r0.w + r0.x;
  r0.x = materialWetnessMultiplier.z * r1.w + r0.x;
  r0.x = materialWetnessMultiplier.w * r0.y + r0.x;
  r3.xyz = v2.xyz * r1.xyz;
  r0.y = specularIntensityMult * specularIntensityMult;
  r0.w = dot(r1.xyz, float3(1.27499998,4.29239988,0.432599992));
  r0.w = 0.5 + -r0.w;
  o2.w = saturate(v3.w + -r0.w);
  r0.w = dot(v3.xyz, v3.xyz);
  r0.w = rsqrt(r0.w);
  r0.w = v3.z * r0.w;
  r0.w = saturate(r0.w * 128 + -127);
  o1.xyz = r2.xyw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r1.x = -0.100000001 + r0.x;
  r1.x = saturate(10 * r1.x);
  o1.w = r1.x * r0.w;
  r0.w = 0.001953125 * specularFalloffMult;
  r1.x = gLightArtificialIntAmbient0.w + v4.x;
  r1.y = v4.y;
  r1.xy = float2(0.5,0.5) * r1.xy;
  o3.xy = sqrt(r1.xy);
  r0.z = r2.z * r0.z + -0.349999994;
  r0.z = saturate(1.53846157 * r0.z);
  r0.z = gDynamicBakesAndWetness.z * r0.z;
  r1.x = 1 + -globalScalars2.z;
  r0.z = r1.x * r0.z;
  r0.z = v4.x * r0.z;
  r1.x = -r0.y * 0.5 + 1;
  r1.x = r1.x * r0.z;
  r1.y = 1 + -r0.x;
  r1.x = r1.x * r1.y;
  r0.x = r0.z * r0.x;
  r0.z = r1.x * -0.5 + 1;
  o0.xyz = r3.xyz * r0.zzz;
  r1.xy = -r0.yw;
  r1.xy = float2(0.5,0.48828125) + r1.xy;
  r1.xy = max(float2(0,0), r1.xy);
  r2.x = r1.x * r0.x + r0.y;
  r2.y = r1.y * r0.x + r0.w;
  o2.z = 0.980000019;
  o2.xy = sqrt(r2.xy);
  o0.w = globalScalars.x;
  o3.zw = float2(0,1.00188386);
  return;
}