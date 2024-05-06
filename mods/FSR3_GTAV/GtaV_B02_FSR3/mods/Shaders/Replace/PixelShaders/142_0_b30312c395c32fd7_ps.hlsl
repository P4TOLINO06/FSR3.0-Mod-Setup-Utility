// ---- FNV Hash b30312c395c32fd7

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov  9 22:12:47 2023

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

cbuffer detail_map_locals : register(b11)
{
  float3 detailSettings : packoffset(c0);
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
SamplerState VolumeSampler_s : register(s2);
SamplerState TextureSamplerDiffPal_s : register(s13);
Texture2D<float4> DiffuseSampler : register(t0);
Texture3D<float4> VolumeSampler : register(t2);
Texture2D<float4> TextureSamplerDiffPal : register(t13);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  float4 pos : POSITION0,
  uint v4 : SV_IsFrontFace0,
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
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.x = dot(v2.xyz, v2.xyz);
  r1.x = rsqrt(r1.x);
  r1.xyzw = v2.zxyz * r1.xxxx;
  r2.x = 255.009995 * r0.w;
  r2.x = floor(r2.x);
  r2.y = -32 + r2.x;
  r3.x = 0.0078125 * r2.y;
  r3.y = paletteSelector;
  r3.xyzw = TextureSamplerDiffPal.Sample(TextureSamplerDiffPal_s, r3.xy).xyzw;
  r2.y = cmp(r2.x >= 32);
  r2.x = cmp(160 >= r2.x);
  r2.x = r2.x ? r2.y : 0;
  r3.xyz = r3.xyz * r0.xyz;
  r3.w = 1;
  r0.xyzw = r2.xxxx ? r3.xyzw : r0.xyzw;
  r0.w = v3.w * r0.w;
  r2.xy = globalScalars.zy * v3.xx;
  r1.xyzw = r1.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
  r2.z = r1.x * gDynamicBakesAndWetness.y + gDynamicBakesAndWetness.x;
  r1.x = 0.300000012 + r1.x;
  r1.x = r1.x * r2.y;
  r2.y = cmp(StubbleGrowth.y != 0.000000);
  if (r2.y != 0) {
    r2.y = cmp(_matMaterialColorScale[1].x == 1.000000);
    if (r2.y != 0) {
      r3.xy = detailSettings.zz * v1.xy;
      r3.z = 0;
      r3.xyzw = VolumeSampler.Sample(VolumeSampler_s, r3.xyz).xyzw;
    } else {
      r4.xy = detailSettings.zz * v1.xy;
      r4.z = 0;
      r4.xyzw = VolumeSampler.Sample(VolumeSampler_s, r4.xyz).xyzw;
      r5.xy = float2(2,2) * v1.xy;
      r5.z = 0;
      r5.xyzw = VolumeSampler.Sample(VolumeSampler_s, r5.xyz).xyzw;
      r2.y = -r5.x + r4.x;
      r3.x = _matMaterialColorScale[1].x * r2.y + r5.x;
    }
    r2.y = -2 + detailSettings.x;
    r2.y = _matMaterialColorScale[1].x * r2.y + 2;
    r2.w = -2 + StubbleGrowth.y;
    r2.w = _matMaterialColorScale[1].x * r2.w + 2;
    r3.x = r3.x * 2 + -1;
    r2.y = r3.x * r2.y;
    r2.y = r2.y * r2.w + 1;
    r0.xyz = r2.yyy * r0.xyz;
  }
  o0.xyz = _matMaterialColorScale[0].xxx * r0.xyz;
  r0.x = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r0.y = r1.x * r0.x;
  o0.w = globalScalars.x * r0.w;
  r3.xyz = float3(256,256,256) * r1.yzw;
  r3.xyz = floor(r3.xyz);
  r1.xyz = r1.yzw * float3(256,256,256) + -r3.xyz;
  r1.xyz = float3(8,8,4) * r1.xyz;
  r1.xyz = floor(r1.xyz);
  r0.z = dot(r1.yxz, float3(4,32,1));
  o1.w = 0.00392156886 * r0.z;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r3.xyz;
  r0.x = r2.z * r2.x + gLightArtificialIntAmbient0.w;
  r0.xy = float2(0.5,0.5) * r0.xy;
  o3.xy = sqrt(r0.xy);
  o2.xyzw = float4(0,0,0.980000019,1);
  o3.zw = float2(0,1);
  return;
}