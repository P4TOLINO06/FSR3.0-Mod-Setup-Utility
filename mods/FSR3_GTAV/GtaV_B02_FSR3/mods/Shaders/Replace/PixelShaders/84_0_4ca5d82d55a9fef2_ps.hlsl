// ---- FNV Hash 4ca5d82d55a9fef2

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

cbuffer ped_common_shared_locals : register(b13)
{
  float4 matWetClothesData : packoffset(c0);
  float4 umPedGlobalOverrideParams : packoffset(c1);
  float4 envEffFatSweatScale : packoffset(c2);
  float paletteSelector : packoffset(c3);
  float2 StubbleGrowth : packoffset(c3.y);
  float4 _matMaterialColorScale[2] : packoffset(c4);
  float4 PedDamageColors[3] : packoffset(c6);
  float4 envEffColorModCpvAdd : packoffset(c9);
  float4 wrinkleMaskStrengths0 : packoffset(c10);
  float4 wrinkleMaskStrengths1 : packoffset(c11);
  float4 wrinkleMaskStrengths2 : packoffset(c12);
  float4 wrinkleMaskStrengths3 : packoffset(c13);
  float4 wrinkleMaskStrengths4 : packoffset(c14);
  float4 wrinkleMaskStrengths5 : packoffset(c15);
  float4 PedDamageData : packoffset(c16);
  float4 wetnessAdjust : packoffset(c17);
  float alphaToCoverageScale : packoffset(c18);
}

cbuffer ped_common_locals2 : register(b10)
{
  float bumpiness : packoffset(c0);
  float specularFresnel : packoffset(c0.y);
  float specularFalloffMult : packoffset(c0.z);
  float specularIntensityMult : packoffset(c0.w);
  float orderNumber : packoffset(c1);
  float furMinLayers : packoffset(c1.y);
  float furMaxLayers : packoffset(c1.z);
  float furLength : packoffset(c1.w);
  float furNoiseUVScale : packoffset(c2);
  float furSelfShadowMin : packoffset(c2.y);
  float furStiffness : packoffset(c2.z);
  float furAOBlend : packoffset(c2.w);
  float3 furAttenCoef : packoffset(c3);
  float3 furGlobalParams : packoffset(c4);
  float4 furBendParams : packoffset(c5);
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
SamplerState NoiseSampler_s : register(s3);
SamplerState BumpSampler_s : register(s4);
SamplerState SpecSampler_s : register(s5);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> NoiseSampler : register(t3);
Texture2D<float4> BumpSampler : register(t4);
Texture2D<float4> SpecSampler : register(t5);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD6,
  float3 v7 : TEXCOORD2,
  float4 pos : POSITION0,
  uint v8 : SV_IsFrontFace0,
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
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)v0.xy;
  r0.xy = (int2)r0.xy & int2(1,1);
  r0.y = (uint)r0.y << 1;
  r0.x = (int)r0.x + (int)r0.y;
  r0.x = dot(globalFade.xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.xy = furNoiseUVScale * v1.xy;
  r1.xyzw = NoiseSampler.Sample(NoiseSampler_s, r1.xy).xyzw;
  r0.w = r0.w * r1.x + -v1.w;
  r1.x = cmp(r0.w < 0.125);
  if (r1.x != 0) discard;
  r0.w = v3.w * r0.w;
  r0.w = globalScalars.x * r0.w;
  r1.x = dot(v0.xy, float2(0.5,0.5));
  r1.x = frac(r1.x);
  r1.x = cmp(r1.x < 0.5);
  r1.yz = cmp(float2(0.237499997,0) >= r0.ww);
  r1.x = r1.y ? r1.x : 0;
  r1.x = (int)r1.z | (int)r1.x;
  if (r1.x != 0) discard;
  r1.xyzw = BumpSampler.Sample(BumpSampler_s, v1.xy).xyzw;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r1.xy, r1.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r1.w = max(0.00100000005, bumpiness);
  r1.xy = r1.xy * r1.ww;
  r2.xyz = v6.xyz * r1.yyy;
  r1.xyw = r1.xxx * v5.xyz + r2.xyz;
  r1.xyz = r1.zzz * v2.xyz + r1.xyw;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r1.xyz * r1.www;
  r3.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r1.xy = r3.xy * r3.xy;
  r2.w = cmp(r3.z >= 0.8125);
  r3.y = specularFalloffMult * r1.y;
  o1.w = saturate(v2.z * 128 + -127);
  r0.xyz = v1.zzz * r0.xyz;
  r3.xw = globalScalars.zy * v3.xx;
  r1.y = r2.z * 0.5 + 0.5;
  r4.x = r1.y * gDynamicBakesAndWetness.y + gDynamicBakesAndWetness.x;
  r4.y = 0.300000012 + r1.y;
  r3.xw = r4.xy * r3.xw;
  r0.xyz = _matMaterialColorScale[0].xxx * r0.xyz;
  r1.y = r2.w ? 0.010000 : 0;
  r2.w = r2.w ? -0.00999999978 : -0;
  r1.x = r1.x * specularIntensityMult + r2.w;
  r1.x = _matMaterialColorScale[0].z * r1.x + r1.y;
  r1.y = dot(v4.xyz, v4.xyz);
  r1.y = rsqrt(r1.y);
  r4.xyz = v4.xyz * r1.yyy;
  r1.y = saturate(dot(r4.xyz, r2.xyz));
  r1.y = 1 + -r1.y;
  r1.y = r1.y * 0.400000006 + 0.5;
  r1.z = r1.z * r1.w + 1;
  r1.z = saturate(r1.z * 0.5 + -0.300000012);
  r1.z = 1.42857146 * r1.z;
  r1.w = saturate(v7.x);
  r1.y = r1.y * r1.w;
  r1.y = r1.y * r1.z;
  r1.yzw = r1.yyy * r0.xyz;
  o0.xyz = r1.yzw * _matMaterialColorScale[0].yyy + r0.xyz;
  r0.x = dot(v5.xyz, v5.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = v5.xyz * r0.xxx;
  r1.y = dot(v6.xyz, v6.xyz);
  r1.y = rsqrt(r1.y);
  r1.yzw = v6.xyz * r1.yyy;
  r0.x = dot(r4.xyz, r0.xyz);
  r0.y = dot(r4.xyz, r1.yzw);
  r4.xy = r0.xy * r0.xy;
  r3.z = 1;
  r0.x = dot(r4.yx, r3.yz);
  r0.x = max(1, r0.x);
  r0.y = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r4.y = r3.w * r0.y;
  o1.xyz = r2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.x = 0.001953125 * r0.x;
  r4.x = r3.x * furAOBlend + gLightArtificialIntAmbient0.w;
  r0.yz = float2(0.5,0.5) * r4.xy;
  o3.xy = sqrt(r0.yz);
  o2.x = sqrt(r1.x);
  o2.y = sqrt(r0.x);
  o0.w = saturate(r0.w * 5.5999999 + 0.00784313772);
  o2.z = specularFresnel;
  o2.w = 1;
  o3.zw = float2(0,1.00188386);
  return;
}