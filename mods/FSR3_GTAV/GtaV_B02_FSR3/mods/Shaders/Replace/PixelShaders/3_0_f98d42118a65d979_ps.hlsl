// ---- FNV Hash f98d42118a65d979

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

cbuffer ped_common_locals2 : register(b10)
{
  float bumpiness : packoffset(c0);
  float specularFresnel : packoffset(c0.y);
  float specularFalloffMult : packoffset(c0.z);
  float specularIntensityMult : packoffset(c0.w);
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
SamplerState BumpSampler_s : register(s3);
SamplerState SpecSampler_s : register(s4);
SamplerState SnowSampler_s : register(s5);
SamplerState pedTattooTargetSampler_s : register(s6);
SamplerState pedBloodTargetSampler_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture3D<float4> VolumeSampler : register(t2);
Texture2D<float4> BumpSampler : register(t3);
Texture2D<float4> SpecSampler : register(t4);
Texture2D<float4> SnowSampler : register(t5);
Texture2D<float4> pedTattooTargetSampler : register(t6);
Texture2D<float4> pedBloodTargetSampler : register(t15);


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
  float4 v7 : TEXCOORD7,
  float3 v8 : TEXCOORD2,
  float4 pos : POSITION0,
  uint v9 : SV_IsFrontFace0,
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
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
  r1.xyz = r1.xyz * r1.www;
  r2.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r3.xy = r2.xy * r2.xy;
  r1.w = cmp(r2.z >= 0.8125);
  r3.z = -r2.z * 16 + 14;
  r3.z = cmp(1 >= abs(r3.z));
  r4.xy = float2(specularIntensityMult, specularFalloffMult) * r3.xy;
  r3.w = cmp(0 != v4.w);
  if (r3.w != 0) {
    r5.xyzw = SnowSampler.Sample(SnowSampler_s, v1.xy).xyzw;
    r5.xyz = r5.xyz * envEffColorModCpvAdd.xyz + -r0.xyz;
    r0.xyz = v4.www * r5.xyz + r0.xyz;
  }
  r0.w = v3.w * r0.w;
  r4.zw = globalScalars.zy * v3.xx;
  r3.w = r1.z * 0.5 + 0.5;
  r5.x = r3.w * gDynamicBakesAndWetness.y + gDynamicBakesAndWetness.x;
  r3.w = 0.300000012 + r3.w;
  r3.w = r3.w * r4.w;
  r4.w = PedDamageData.x * v7.z;
  r4.w = cmp(r4.w != 0.000000);
  if (r4.w != 0) {
    r6.xz = frac(v7.yx);
    r6.w = r6.x * abs(v7.z) + abs(v7.w);
    r6.x = r6.x * v1.w + v2.w;
    r4.w = frac(PedDamageData.z);
    r4.w = cmp(0.100000001 < r4.w);
    r6.y = 1 + -r6.z;
    r7.xyzw = r4.wwww ? r6.wywy : r6.zwzw;
    r5.y = cmp(PedDamageData.z >= 1);
    r5.yz = r5.yy ? r6.xy : r6.zx;
    r6.xyzw = pedTattooTargetSampler.SampleLevel(pedTattooTargetSampler_s, r5.yz, 0).xyzw;
    r8.xyzw = pedBloodTargetSampler.SampleLevel(pedBloodTargetSampler_s, r7.zw, 0).zxyw;
    r5.y = cmp(r6.w >= 0.501960814);
    r5.z = cmp(0.501960814 >= r6.w);
    r5.y = r1.w ? r5.y : r5.z;
    r5.z = cmp(0 < PedDamageData.x);
    r5.y = r5.z ? r5.y : 0;
    r6.xyzw = r5.yyyy ? r6.xyzw : float4(0,0,0,0.5);
    r5.y = r6.w * 2 + -1;
    r5.y = 1 + -abs(r5.y);
    r5.z = 1 + -r8.x;
    r5.w = r5.z * r5.z;
    r5.w = r5.w * r8.y;
    r3.y = -r3.y * specularFalloffMult + PedDamageColors[0].w;
    r4.y = r5.w * r3.y + r4.y;
    r3.x = -r3.x * specularIntensityMult + PedDamageColors[1].w;
    r4.x = r5.w * r3.x + r4.x;
    r9.xyz = r1.www ? r0.xyz : float3(1,1,1);
    r6.xyz = r9.xyz * r6.xyz;
    r6.xyz = r0.xyz * r5.yyy + r6.xyz;
    r3.x = r1.w ? 0 : r8.z;
    r9.xyz = r6.xyz * PedDamageColors[1].xyz + -r6.xyz;
    r6.xyz = r3.xxx * r9.xyz + r6.xyz;
    r9.xyz = PedDamageColors[0].xyz * r8.yyy;
    r0.xyz = r6.xyz * r8.xxx + r9.xyz;
    r3.x = cmp(PedDamageData.y != 0.000000);
    if (r3.x != 0) {
      r3.x = cmp(0.150000006 < v7.z);
      r6.yw = frac(PedDamageData.ww);
      r6.xz = float2(0.400000006,0.400000006) * r6.ww;
      r6.xyzw = r4.wwww ? r6.xyzw : r6.wzwz;
      r3.x = cmp((int)r4.w == (int)r3.x);
      r9.xyzw = r3.xxxx ? float4(1,0,0,1) : float4(0,-1,-1,0);
      r6.xyzw = r9.xyzw * r6.xyzw + r7.xyzw;
      r7.xyzw = pedBloodTargetSampler.SampleLevel(pedBloodTargetSampler_s, r6.xy, 0).xyzw;
      r6.xyzw = pedBloodTargetSampler.SampleLevel(pedBloodTargetSampler_s, r6.zw, 0).yzxw;
      r3.x = r1.w ? 1.000000 : 0;
      r9.x = r6.w + -r8.w;
      r9.y = r7.w + -r8.w;
      r6.x = r8.y;
      r6.y = r7.x;
      r3.y = r6.x * r5.z;
      r5.yz = r6.zy * r5.zz + -r3.yy;
      r3.xy = r3.xx * r9.xy + r5.yz;
      r6.xy = PedDamageData.yy * r3.xy;
      r3.x = dot(r6.xy, r6.xy);
      r3.x = 1 + -r3.x;
      r3.x = max(0, r3.x);
      r5.yz = cmp(v7.zw < float2(0,0));
      r5.zw = r5.zz ? r6.yx : r6.xy;
      r6.z = -r6.x;
      r5.yz = r5.yy ? r6.yz : r5.zw;
      r6.xyz = v6.xyz * r5.zzz;
      r5.yzw = r5.yyy * v5.xyz + r6.xyz;
      r5.yzw = r3.xxx * r1.xyz + r5.yzw;
      r3.x = dot(r5.yzw, r5.yzw);
      r3.x = rsqrt(r3.x);
      r1.xyz = r5.yzw * r3.xxx;
    }
  } else {
    r8.x = 1;
  }
  r3.x = cmp(StubbleGrowth.y != 0.000000);
  if (r3.x != 0) {
    r2.w = r8.x * r2.w;
    r3.x = cmp(_matMaterialColorScale[1].x == 1.000000);
    if (r3.x != 0) {
      r2.xy = detailSettings.zz * v1.xy;
      r6.xyzw = VolumeSampler.Sample(VolumeSampler_s, r2.xyz).yzxw;
      r6.xy = r6.xy * float2(2,2) + float2(-1,-1);
    } else {
      r2.xy = detailSettings.zz * v1.xy;
      r7.xyzw = VolumeSampler.Sample(VolumeSampler_s, r2.xyz).xyzw;
      r3.x = r1.w ? 2 : 3;
      r2.xy = v1.xy * r3.xx;
      r9.xyzw = VolumeSampler.Sample(VolumeSampler_s, r2.xyz).xyzw;
      r2.xyz = r9.yzx * float3(2,2,1) + float3(-1,-1,0);
      r5.yzw = r7.yzx * float3(2,2,1) + float3(-1,-1,0);
      r5.yzw = r5.yzw + -r2.xyz;
      r6.xyz = _matMaterialColorScale[1].xxx * r5.yzw + r2.xyz;
    }
    r7.xyzw = r1.wwww ? float4(2,-2,2,-2) : float4(1,-1,1.5,-1.5);
    r2.xy = detailSettings.xy + r7.yw;
    r2.xy = _matMaterialColorScale[1].xx * r2.xy + r7.xz;
    r2.z = StubbleGrowth.y + r7.y;
    r2.z = _matMaterialColorScale[1].x * r2.z + r7.x;
    r3.x = r6.z * 2 + -1;
    r2.x = r3.x * r2.x;
    r2.x = r2.x * r2.w;
    r2.x = r2.x * r2.z + 1;
    r0.xyz = r2.xxx * r0.xyz;
    r5.yzw = v6.xyz * r6.yyy;
    r5.yzw = v5.xyz * r6.xxx + r5.yzw;
    r5.yzw = r5.yzw * r2.yyy;
    r2.xyw = r5.yzw * r2.www;
    r2.xyz = r2.xyw * r2.zzz + r1.xyz;
    r2.w = dot(r2.xyz, r2.xyz);
    r2.w = rsqrt(r2.w);
    r1.xyz = r2.xyz * r2.www;
  }
  r2.xy = float2(0,-0.75) + v1.zz;
  r2.xy = saturate(float2(4,4) * r2.xy);
  r2.z = cmp((int)r1.w == 0);
  r5.yzw = wetnessAdjust.xxx * r0.xyz;
  r5.yzw = r5.yzw * r2.xxx;
  r2.xzw = r2.zzz ? r5.yzw : 0;
  r0.xyz = -r2.xzw + r0.xyz;
  r2.xy = wetnessAdjust.yz * r2.yy + r4.yx;
  r0.xyz = _matMaterialColorScale[0].xxx * r0.xyz;
  r2.z = r1.w ? 0.010000 : 0;
  r1.w = r1.w ? -0.00999999978 : -0;
  r1.w = r2.y + r1.w;
  r1.w = _matMaterialColorScale[0].z * r1.w + r2.z;
  r2.y = dot(v4.xyz, v4.xyz);
  r2.y = rsqrt(r2.y);
  r4.xyw = v4.xyz * r2.yyy;
  r2.z = dot(r1.xyz, r1.xyz);
  r2.z = rsqrt(r2.z);
  r5.yzw = r2.zzz * r1.xyz;
  r2.z = saturate(dot(r4.xyw, r5.yzw));
  r2.z = 0.5 + -r2.z;
  r2.z = saturate(2.5 * r2.z);
  r2.w = r2.z * -2 + 3;
  r2.z = r2.z * r2.z;
  r2.z = r2.w * r2.z;
  r2.w = 1 + r1.z;
  r2.w = saturate(r2.w * 0.5 + -0.300000012);
  r2.w = 1.42857146 * r2.w;
  r4.xyw = saturate(v8.xyz);
  r2.z = r4.x * r2.z;
  r2.z = r2.z * r2.w;
  r5.yzw = r2.zzz * r0.xyz;
  o0.xyz = r5.yzw * _matMaterialColorScale[0].yyy + r0.xyz;
  r0.xyz = v4.xyz * r2.yyy + -r1.xyz;
  r0.xyz = r4.yyy * r0.xyz + r1.xyz;
  r1.x = 1 + -r8.x;
  r1.y = PedDamageColors[2].y + -r4.w;
  r1.x = r1.x * r1.y + r4.w;
  r1.y = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r3.y = r3.w * r1.y;
  o0.w = globalScalars.x * r0.w;
  r0.xyz = r0.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r2.yzw = float3(256,256,256) * r0.xyz;
  r2.yzw = floor(r2.yzw);
  r0.xyz = r0.xyz * float3(256,256,256) + -r2.yzw;
  r0.xyz = float3(8,8,4) * r0.xyz;
  r0.xyz = floor(r0.xyz);
  r0.x = dot(r0.yxz, float3(4,32,1));
  o1.w = 0.00392156886 * r0.x;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r2.yzw;
  r0.x = 0.001953125 * r2.x;
  r3.x = r5.x * r4.z + gLightArtificialIntAmbient0.w;
  r0.yz = float2(0.5,0.5) * r3.xy;
  o3.xy = sqrt(r0.yz);
  r0.y = 1.0196079 + r1.x;
  r0.y = r3.z ? r1.x : r0.y;
  o3.w = 0.496078432 * r0.y;
  o2.x = sqrt(r1.w);
  o2.y = sqrt(r0.x);
  o2.z = specularFresnel;
  o2.w = 1;
  o3.z = 0;
  return;
}