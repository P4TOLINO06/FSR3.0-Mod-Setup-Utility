// ---- FNV Hash 2398f416300e9bc7

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

cbuffer megashader_locals : register(b12)
{
  float tessellationMultiplier : packoffset(c0);
  float specularFresnel : packoffset(c0.y);
  float specularFalloffMult : packoffset(c0.z);
  float specularIntensityMult : packoffset(c0.w);
  float3 specMapIntMask : packoffset(c1);
  float bumpiness : packoffset(c1.w);
  float heightScale : packoffset(c2);
  float heightBias : packoffset(c2.y);
  float wetnessMultiplier : packoffset(c2.z);
  float useTessellation : packoffset(c2.w);
  float HardAlphaBlend : packoffset(c3);
}

cbuffer detail_map_locals : register(b11)
{
  float4 detailSettings : packoffset(c0);
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
SamplerState DetailSampler_s : register(s3);
SamplerState BumpSampler_s : register(s5);
SamplerState SpecSampler_s : register(s6);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> DetailSampler : register(t3);
Texture2D<float4> BumpSampler : register(t5);
Texture2D<float4> SpecSampler : register(t6);


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
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = detailSettings.zw * v3.xy;
  r0.zw = float2(3.17000008,3.17000008) * r0.xy;
  r1.xyzw = DetailSampler.Sample(DetailSampler_s, r0.xy).xyzw;
  r0.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.xyzw = DetailSampler.Sample(DetailSampler_s, r0.zw).xyzw;
  r0.zw = r1.xy * float2(2,2) + float2(-1,-1);
  r0.zw = float2(0.5,0.5) * r0.zw;
  r0.xy = r0.xy * float2(0.5,0.5) + r0.zw;
  r0.yz = detailSettings.yy * r0.xy;
  r0.x = detailSettings.x * -r0.x;
  r1.xyzw = BumpSampler.Sample(BumpSampler_s, v3.xy).xyzw;
  r2.xyzw = SpecSampler.Sample(SpecSampler_s, v3.xy).xyzw;
  r0.yz = r0.yz * r2.ww + r1.xy;
  r0.yz = r0.yz * float2(2,2) + float2(-1,-1);
  r0.w = max(0.00100000005, bumpiness);
  r1.xy = r0.yz * r0.ww;
  r0.y = dot(r0.yz, r0.yz);
  r0.y = 1 + -r0.y;
  r0.y = sqrt(abs(r0.y));
  r1.yzw = v6.xyz * r1.yyy;
  r1.xyz = r1.xxx * v5.xyz + r1.yzw;
  r0.yzw = r0.yyy * v4.xyz + r1.xyz;
  r1.x = dot(r0.yzw, r0.yzw);
  r1.x = rsqrt(r1.x);
  r1.y = r0.w * r1.x + -0.349999994;
  r0.yzw = r1.xxx * r0.yzw;
  o1.xyz = r0.yzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.y = saturate(1.53846157 * r1.y);
  r0.y = gDynamicBakesAndWetness.z * r0.y;
  r0.z = 1 + -globalScalars2.z;
  r0.y = r0.y * r0.z;
  r1.yz = globalScalars.zy * v1.xy;
  r0.y = r1.y * r0.y;
  r0.x = r0.x * r2.w + 1;
  r2.xy = r2.xy * r2.xy;
  r0.z = specularFalloffMult * r2.w;
  r3.y = 0.001953125 * r0.z;
  r0.z = dot(r2.xyz, specMapIntMask.xyz);
  r0.z = specularIntensityMult * r0.z;
  r3.x = r0.z * r0.x;
  r0.z = saturate(r0.z * r0.x + 0.400000006);
  r2.xy = float2(0.5,0.48828125) * r0.zz;
  r0.z = -r3.x * 0.5 + 1;
  r0.z = r0.y * r0.z;
  r0.y = wetnessMultiplier * r0.y;
  r0.z = r0.z * -0.5 + 1;
  r4.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v3.xy).xyzw;
  r4.xyzw = r4.xyzw * r0.xxxx;
  r4.xyz = v2.xyz * r4.xyz;
  r0.x = v1.w * r4.w;
  o0.w = globalScalars.x * r0.x;
  o0.xyz = r4.xyz * r0.zzz;
  r0.x = -0.200000003 + wetnessMultiplier;
  r0.x = saturate(10 * r0.x);
  r0.z = saturate(v4.z * 128 + -127);
  o1.w = r0.z * r0.x;
  r2.z = 0.970000029;
  r3.z = specularFresnel;
  r0.xzw = -r3.xyz + r2.xyz;
  r0.xzw = max(float3(0,0,0), r0.xzw);
  r0.xyz = r0.xzw * r0.yyy + r3.xyz;
  o2.xy = sqrt(r0.xy);
  o2.z = r0.z;
  o2.w = 1;
  r1.x = v1.x * globalScalars.z + gLightArtificialIntAmbient0.w;
  r0.xy = float2(0.5,0.5) * r1.xz;
  o3.xy = sqrt(r0.xy);
  o3.zw = float2(0,1.00188386);
  return;
}