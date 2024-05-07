// ---- FNV Hash 9f88793032dc6310

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov  9 22:12:47 2023

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
  float2 anisotropicSpecularIntensity : packoffset(c0);
  float2 anisotropicSpecularExponent : packoffset(c0.z);
  float4 anisotropicSpecularColour : packoffset(c1);
  float4 specularNoiseMapUVScaleFactor : packoffset(c2);
  float bumpiness : packoffset(c3);
  float specularFresnel : packoffset(c3.y);
  float specularFalloffMult : packoffset(c3.z);
  float specularIntensityMult : packoffset(c3.w);
}

cbuffer pedmisclocals : register(b8)
{
  float AnisotropicAlphaBias : packoffset(c0);
  float4 umGlobalParams : packoffset(c1);
}

SamplerState DiffuseSampler_s : register(s0);
SamplerState AnisoNoiseSpecSampler_s : register(s3);
SamplerState BumpSampler_s : register(s4);
SamplerState SpecSampler_s : register(s5);
SamplerState TextureSamplerDiffPal_s : register(s13);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> AnisoNoiseSpecSampler : register(t3);
Texture2D<float4> BumpSampler : register(t4);
Texture2D<float4> SpecSampler : register(t5);
Texture2D<float4> TextureSamplerDiffPal : register(t13);


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
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.x = r0.y;
  r1.y = paletteSelector;
  r2.xyzw = TextureSamplerDiffPal.Sample(TextureSamplerDiffPal_s, r1.xy).xyzw;
  r0.y = cmp(StubbleGrowth.x != paletteSelector);
  if (r0.y != 0) {
    r1.z = StubbleGrowth.x;
    r1.xyzw = TextureSamplerDiffPal.Sample(TextureSamplerDiffPal_s, r1.xz).xyzw;
    r0.y = 1 + -r0.x;
    r3.xyz = r2.xyz * r0.yyy;
    r2.xyz = r1.xyz * r0.xxx + r3.xyz;
  }
  r0.xy = specularNoiseMapUVScaleFactor.xy * v1.xy;
  r0.xy = float2(0.5,0.5) * r0.xy;
  r1.xyzw = AnisoNoiseSpecSampler.Sample(AnisoNoiseSpecSampler_s, r0.xy).xyzw;
  r0.x = saturate(r1.w * 2 + AnisotropicAlphaBias);
  r0.x = r0.w * r0.x;
  r0.x = globalScalars.x * r0.x;
  r0.y = dot(v0.xy, float2(0.5,0.5));
  r0.y = frac(r0.y);
  r0.y = cmp(r0.y < 0.5);
  r0.zw = cmp(float2(0.949999988,0.501960814) >= r0.xx);
  r0.y = r0.z ? r0.y : 0;
  r0.y = (int)r0.w | (int)r0.y;
  if (r0.y != 0) discard;
  r3.xyzw = BumpSampler.Sample(BumpSampler_s, v1.xy).xyzw;
  r0.yz = r3.xy * float2(2,2) + float2(-1,-1);
  r0.w = dot(r0.yz, r0.yz);
  r0.w = 1 + -r0.w;
  r0.w = sqrt(abs(r0.w));
  r1.y = max(0.00100000005, bumpiness);
  r0.yz = r1.yy * r0.yz;
  r1.yzw = v6.xyz * r0.zzz;
  r1.yzw = r0.yyy * v5.xyz + r1.yzw;
  r0.yzw = r0.www * v2.xyz + r1.yzw;
  r1.y = dot(r0.yzw, r0.yzw);
  r1.y = rsqrt(r1.y);
  r3.xyz = r1.yyy * r0.yzw;
  r4.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r0.yz = r4.yx * r4.yx;
  r1.z = cmp(r4.z >= 0.8125);
  o1.w = saturate(v2.z * 128 + -127);
  r4.xy = globalScalars.zy * v3.xx;
  r1.w = r3.z * 0.5 + 0.5;
  r2.w = r1.w * gDynamicBakesAndWetness.y + gDynamicBakesAndWetness.x;
  r1.w = 0.300000012 + r1.w;
  r1.w = r1.w * r4.y;
  r4.yw = float2(0,-0.75) + v1.zz;
  r4.yw = saturate(float2(4,4) * r4.yw);
  r3.w = cmp((int)r1.z == 0);
  r5.xyz = wetnessAdjust.xxx * r2.xyz;
  r5.xyz = r5.xyz * r4.yyy;
  r5.xyz = r3.www ? r5.xyz : 0;
  r2.xyz = -r5.xyz + r2.xyz;
  r4.yw = wetnessAdjust.yz * r4.ww;
  r0.yz = r0.yz * float2(specularFalloffMult, specularIntensityMult) + r4.yw;
  r2.xyz = _matMaterialColorScale[0].xxx * r2.xyz;
  r3.w = r1.z ? 0.010000 : 0;
  r1.z = r1.z ? -0.00999999978 : -0;
  r0.z = r1.z + r0.z;
  r0.z = _matMaterialColorScale[0].z * r0.z + r3.w;
  r1.z = dot(v4.xyz, v4.xyz);
  r1.z = rsqrt(r1.z);
  r5.xyz = v4.xyz * r1.zzz;
  r1.z = saturate(dot(r5.xyz, r3.xyz));
  r1.z = 1 + -r1.z;
  r1.z = r1.z * 0.400000006 + 0.5;
  r0.w = r0.w * r1.y + 1;
  r0.w = saturate(r0.w * 0.5 + -0.300000012);
  r0.w = 1.42857146 * r0.w;
  r1.y = saturate(v7.x);
  r1.y = r1.z * r1.y;
  r0.w = r1.y * r0.w;
  r6.xyz = r0.www * r2.xyz;
  r2.xyz = r6.xyz * _matMaterialColorScale[0].yyy + r2.xyz;
  r0.w = dot(v6.xyz, v6.xyz);
  r0.w = rsqrt(r0.w);
  r6.xyz = v6.xyz * r0.www;
  r1.yz = specularNoiseMapUVScaleFactor.zw * v1.xy;
  r1.yz = float2(0.5,0.5) * r1.yz;
  r7.xyzw = AnisoNoiseSpecSampler.Sample(AnisoNoiseSpecSampler_s, r1.yz).xyzw;
  r1.yz = r7.xy * float2(2,2) + float2(-1,-1);
  r1.yz = float2(0.100000001,0.100000001) * r1.yz;
  r7.xyz = v2.xyz * r1.yyy + r6.xyz;
  r0.w = dot(r7.xyz, r7.xyz);
  r0.w = rsqrt(r0.w);
  r7.xyz = r7.xyz * r0.www;
  r0.w = dot(r5.xyz, r7.xyz);
  r1.y = dot(gViewInverse._m20_m21_m22, r7.xyz);
  r6.xyz = v2.xyz * r1.zzz + r6.xyz;
  r1.z = dot(r6.xyz, r6.xyz);
  r1.z = rsqrt(r1.z);
  r6.xyz = r6.xyz * r1.zzz;
  r1.z = dot(r5.xyz, r6.xyz);
  r3.w = dot(gViewInverse._m20_m21_m22, r6.xyz);
  r4.y = -r0.w * r0.w + 1;
  r4.w = -r1.y * r1.y + 1;
  r4.yw = sqrt(r4.yw);
  r0.w = r1.y * r0.w;
  r0.w = r4.y * r4.w + -r0.w;
  r1.y = -r1.z * r1.z + 1;
  r1.y = sqrt(r1.y);
  r4.y = -r3.w * r3.w + 1;
  r4.y = sqrt(r4.y);
  r1.z = r3.w * r1.z;
  r1.y = r1.y * r4.y + -r1.z;
  r4.yw = float2(8,16) + anisotropicSpecularExponent.xy;
  r0.w = log2(abs(r0.w));
  r0.w = r4.y * r0.w;
  r0.w = exp2(r0.w);
  r1.y = log2(abs(r1.y));
  r1.y = r4.w * r1.y;
  r1.y = exp2(r1.y);
  r1.z = anisotropicSpecularIntensity.y * r1.y;
  r0.w = r0.w * anisotropicSpecularIntensity.x + r1.z;
  r1.z = cmp(r4.z < 0.03125);
  r3.w = r1.z ? 1.000000 : 0;
  r0.w = r0.w * r1.x;
  r0.w = r1.z ? r0.w : 1;
  r0.z = r0.z * r0.w;
  r1.xyz = anisotropicSpecularColour.xyz * r1.yyy;
  r1.xyz = r1.xyz * r3.www;
  o0.xyz = r1.xyz * float3(0.5,0.5,0.5) + r2.xyz;
  r0.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r1.y = r1.w * r0.w;
  o1.xyz = r3.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.y = 0.001953125 * r0.y;
  r1.x = r2.w * r4.x + gLightArtificialIntAmbient0.w;
  r1.xy = float2(0.5,0.5) * r1.xy;
  o3.xy = sqrt(r1.xy);
  o2.xy = sqrt(r0.zy);
  r0.x = r0.x * 1.33000004 + -0.501960814;
  o0.w = saturate(r0.x * 2.23194742 + 0.00784313772);
  o2.z = specularFresnel;
  o2.w = 1;
  o3.zw = float2(0,1.00188386);
  return;
}