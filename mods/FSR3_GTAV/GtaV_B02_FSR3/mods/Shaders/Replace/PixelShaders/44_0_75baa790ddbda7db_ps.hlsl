// ---- FNV Hash 75baa790ddbda7db

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:20 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

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
  float specularFresnel : packoffset(c0);
  float specularFalloffMult : packoffset(c0.y);
  float specularIntensityMult : packoffset(c0.z);
  float3 specMapIntMask : packoffset(c1);
  float bumpiness : packoffset(c1.w);
  float wetnessMultiplier : packoffset(c2);
  float useTessellation : packoffset(c2.y);
  float HardAlphaBlend : packoffset(c2.z);
}

cbuffer grass_fur_locals : register(b10)
{
  float4 furLayerParams : packoffset(c0);
  float4 furUvScales : packoffset(c1);
  float2 furAlphaDistance : packoffset(c2);
  float4 furAlphaClip03 : packoffset(c3);
  float4 furAlphaClip47 : packoffset(c4);
  float4 furShadow03 : packoffset(c5);
  float4 furShadow47 : packoffset(c6);
}

SamplerState DiffuseSampler_s : register(s0);
SamplerState BumpSampler_s : register(s2);
SamplerState SpecSampler_s : register(s3);
SamplerState ComboHeightSamplerFur67_s : register(s7);
SamplerState FurMaskSampler_s : register(s8);
SamplerState DiffuseHfSampler_s : register(s9);
SamplerState StippleSampler_s : register(s10);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> BumpSampler : register(t2);
Texture2D<float4> SpecSampler : register(t3);
Texture2D<float4> ComboHeightSamplerFur67 : register(t7);
Texture2D<float4> FurMaskSampler : register(t8);
Texture2D<float4> DiffuseHfSampler : register(t9);
Texture2D<float4> StippleSampler : register(t10);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float4 v6 : TEXCOORD5,
  float4 v7 : TEXCOORD6,
  float4 v8 : TEXCOORD7,
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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = gViewInverse._m30_m31_m32 + -v4.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = saturate(r0.x * v3.w + v3.z);
  r0.y = 3.99600005 * r0.x;
  r0.z = frac(r0.y);
  r0.z = 4 * r0.z;
  r0.yz = floor(r0.yz);
  r1.xy = float2(0.25,0.25) * r0.zy;
  r0.yz = float2(1041.66663,1041.66663) * v0.xy;
  r1.zw = cmp(r0.yz >= -r0.yz);
  r0.yz = frac(abs(r0.yz));
  r0.yz = r1.zw ? r0.yz : -r0.yz;
  r0.yz = r0.yz * float2(0.25,0.25) + r1.xy;
  r1.xyzw = StippleSampler.Sample(StippleSampler_s, r0.yz).xyzw;
  r0.y = cmp(0 < r1.x);
  r0.y = cmp((int)r0.y == 0);
  if (r0.y != 0) discard;
  r0.yzw = -gPlayerLFootPos.xyz + v4.xyz;
  r0.z = dot(r0.yzw, r0.yzw);
  r0.z = 28 * r0.z;
  r0.z = min(1, r0.z);
  r1.xyz = -gPlayerRFootPos.xyz + v4.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = 28 * r0.w;
  r0.w = min(1, r0.w);
  r0.zw = float2(1,1) + -r0.zw;
  r0.y = r0.y * r0.z;
  r0.z = r1.x * r0.w;
  r1.xyzw = r0.yyyy * float4(0.159999996,0.159999996,0.159999996,0.159999996) + v2.xyzw;
  r1.xyzw = r0.zzzz * float4(0.159999996,0.159999996,0.159999996,0.159999996) + r1.xyzw;
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, r1.xy).xyzw;
  r1.x = v6.w;
  r1.y = v7.w;
  r3.xyzw = BumpSampler.Sample(BumpSampler_s, r1.xy).xyzw;
  r0.yz = r3.xy * float2(2,2) + float2(-1,-1);
  r0.w = dot(r0.yz, r0.yz);
  r0.w = 1 + -r0.w;
  r0.w = sqrt(abs(r0.w));
  r1.x = max(0.00100000005, bumpiness);
  r0.yz = r1.xx * r0.yz;
  r3.xyz = v7.xyz * r0.zzz;
  r3.xyz = r0.yyy * v6.xyz + r3.xyz;
  r0.yzw = r0.www * v5.xyz + r3.xyz;
  r1.x = dot(r0.yzw, r0.yzw);
  r1.x = rsqrt(r1.x);
  r3.xyz = r1.xxx * r0.yzw;
  r4.xyzw = SpecSampler.Sample(SpecSampler_s, v2.xy).xyzw;
  r4.xy = r4.xy * r4.xy;
  r0.y = dot(r4.xyz, specMapIntMask.xyz);
  r4.x = specularIntensityMult * r0.y;
  r0.z = specularFalloffMult * r4.w;
  r1.y = saturate(v5.z * 128 + -127);
  r5.xyzw = DiffuseHfSampler.Sample(DiffuseHfSampler_s, v8.zw).xyzw;
  r2.xyz = r5.xyz * r2.xyz;
  r5.xyzw = ComboHeightSamplerFur67.Sample(ComboHeightSamplerFur67_s, r1.zw).xyzw;
  r6.xyzw = FurMaskSampler.Sample(FurMaskSampler_s, v8.xy).xyzw;
  r1.z = v1.w * r6.x;
  r1.w = r5.y * r1.z;
  r2.w = -furLayerParams.w + v3.x;
  r0.x = r2.w * r0.x;
  r0.x = r1.z * r0.x + furLayerParams.w;
  r1.z = saturate(r1.z + r1.z);
  r2.w = -0.00999999978 + v3.y;
  r1.z = r1.z * r2.w + 0.00999999978;
  r1.z = cmp(r1.w < r1.z);
  if (r1.z != 0) discard;
  r2.xyz = r2.xyz * r0.xxx;
  r5.yz = globalScalars.zy * v1.xy;
  o1.xyz = r3.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r1.zw = wetnessMultiplier * float2(9.99999997e-07,9.99999997e-07) + float2(0.600000024,0.400000006);
  r0.x = saturate(10 * r1.w);
  o1.w = r1.y * r0.x;
  r4.y = 0.001953125 * r0.z;
  r5.x = v1.x * globalScalars.z + gLightArtificialIntAmbient0.w;
  r0.xz = float2(0.5,0.5) * r5.xz;
  o3.xy = sqrt(r0.xz);
  r0.x = r0.w * r1.x + -0.349999994;
  r0.x = saturate(1.53846157 * r0.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.z = 1 + -globalScalars2.z;
  r0.x = r0.x * r0.z;
  r0.x = r0.x * r5.y;
  r0.z = -r4.x * 0.5 + 1;
  r0.z = r0.x * r0.z;
  r0.w = 1 + -r1.z;
  r0.z = r0.z * r0.w;
  r0.x = r0.x * r1.z;
  r0.z = r0.z * -0.5 + 1;
  o0.xyz = r2.xyz * r0.zzz;
  r0.y = saturate(r0.y * specularIntensityMult + 0.400000006);
  r1.xy = float2(0.5,0.48828125) * r0.yy;
  r4.z = specularFresnel;
  r1.z = 0.970000029;
  r0.yzw = -r4.xyz + r1.xyz;
  r0.yzw = max(float3(0,0,0), r0.yzw);
  r0.xyz = r0.yzw * r0.xxx + r4.xyz;
  o2.xy = sqrt(r0.xy);
  o0.w = globalScalars.x;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188386);
  return;
}