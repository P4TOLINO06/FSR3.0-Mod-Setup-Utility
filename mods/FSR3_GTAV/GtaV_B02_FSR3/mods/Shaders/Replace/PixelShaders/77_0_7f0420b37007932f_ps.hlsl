// ---- FNV Hash 7f0420b37007932f

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
SamplerState pedTattooTargetSampler_s : register(s6);
SamplerState WrinkleMaskSampler_0_s : register(s7);
SamplerState WrinkleMaskSampler_1_s : register(s8);
SamplerState WrinkleMaskSampler_2_s : register(s9);
SamplerState WrinkleMaskSampler_3_s : register(s10);
SamplerState WrinkleSampler_A_s : register(s11);
SamplerState WrinkleSampler_B_s : register(s12);
SamplerState pedBloodTargetSampler_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture3D<float4> VolumeSampler : register(t2);
Texture2D<float4> BumpSampler : register(t3);
Texture2D<float4> SpecSampler : register(t4);
Texture2D<float4> pedTattooTargetSampler : register(t6);
Texture2D<float4> WrinkleMaskSampler_0 : register(t7);
Texture2D<float4> WrinkleMaskSampler_1 : register(t8);
Texture2D<float4> WrinkleMaskSampler_2 : register(t9);
Texture2D<float4> WrinkleMaskSampler_3 : register(t10);
Texture2D<float4> WrinkleSampler_A : register(t11);
Texture2D<float4> WrinkleSampler_B : register(t12);
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
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
  r1.x = globalScalars.x * r0.w;
  r1.y = cmp(alphaToCoverageScale != 0.000000);
  r1.z = ~(int)r1.y;
  r1.w = cmp(0.501960814 >= r1.x);
  r1.z = r1.w ? r1.z : 0;
  if (r1.z != 0) discard;
  r2.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r1.zw = r2.xy * r2.xy;
  r3.x = cmp(r2.z >= 0.8125);
  r3.y = -r2.z * 16 + 14;
  r3.y = cmp(1 >= abs(r3.y));
  r3.zw = float2(specularIntensityMult, specularFalloffMult) * r1.zw;
  r4.xyzw = WrinkleMaskSampler_0.Sample(WrinkleMaskSampler_0_s, v1.xy).xyzw;
  r4.x = dot(wrinkleMaskStrengths0.xyzw, r4.xyzw);
  r5.xyzw = WrinkleMaskSampler_1.Sample(WrinkleMaskSampler_1_s, v1.xy).xyzw;
  r4.y = dot(wrinkleMaskStrengths1.xyzw, r5.xyzw);
  r4.x = r4.x + r4.y;
  r5.xyzw = WrinkleMaskSampler_2.Sample(WrinkleMaskSampler_2_s, v1.xy).xyzw;
  r4.y = dot(wrinkleMaskStrengths2.xyzw, r5.xyzw);
  r5.xyzw = WrinkleMaskSampler_3.Sample(WrinkleMaskSampler_3_s, v1.xy).xyzw;
  r4.z = dot(wrinkleMaskStrengths3.xyzw, r5.xyzw);
  r4.y = r4.y + r4.z;
  r5.xyzw = BumpSampler.Sample(BumpSampler_s, v1.xy).xyzw;
  r6.xyzw = WrinkleSampler_A.Sample(WrinkleSampler_A_s, v1.xy).xyzw;
  r4.zw = r6.xy + -r5.xy;
  r4.xz = r4.xx * r4.zw + r5.xy;
  r5.xyzw = WrinkleSampler_B.Sample(WrinkleSampler_B_s, v1.xy).xyzw;
  r5.xy = r5.xy + -r4.xz;
  r4.xy = r4.yy * r5.xy + r4.xz;
  r4.xy = r4.xy * float2(2,2) + float2(-1,-1);
  r4.z = dot(r4.xy, r4.xy);
  r4.z = 1 + -r4.z;
  r4.z = sqrt(abs(r4.z));
  r4.w = max(0.00100000005, bumpiness);
  r4.xy = r4.xy * r4.ww;
  r5.xyz = v6.xyz * r4.yyy;
  r4.xyw = r4.xxx * v5.xyz + r5.xyz;
  r4.xyz = r4.zzz * v2.xyz + r4.xyw;
  r4.w = dot(r4.xyz, r4.xyz);
  r4.w = rsqrt(r4.w);
  r4.xyz = r4.xyz * r4.www;
  r0.w = v3.w * r0.w;
  r5.xy = globalScalars.zy * v3.xx;
  r4.w = r4.z * 0.5 + 0.5;
  r5.z = r4.w * gDynamicBakesAndWetness.y + gDynamicBakesAndWetness.x;
  r4.w = 0.300000012 + r4.w;
  r4.w = r4.w * r5.y;
  r5.y = PedDamageData.x * v7.z;
  r5.y = cmp(r5.y != 0.000000);
  if (r5.y != 0) {
    r6.xz = frac(v7.yx);
    r6.w = r6.x * abs(v7.z) + abs(v7.w);
    r6.x = r6.x * v1.w + v2.w;
    r5.y = frac(PedDamageData.z);
    r5.y = cmp(0.100000001 < r5.y);
    r6.y = 1 + -r6.z;
    r7.xyzw = r5.yyyy ? r6.wywy : r6.zwzw;
    r5.w = cmp(PedDamageData.z >= 1);
    r6.xy = r5.ww ? r6.xy : r6.zx;
    r6.xyzw = pedTattooTargetSampler.SampleLevel(pedTattooTargetSampler_s, r6.xy, 0).xyzw;
    r8.xyzw = pedBloodTargetSampler.SampleLevel(pedBloodTargetSampler_s, r7.zw, 0).zxyw;
    r5.w = cmp(r6.w >= 0.501960814);
    r9.x = cmp(0.501960814 >= r6.w);
    r5.w = r3.x ? r5.w : r9.x;
    r9.x = cmp(0 < PedDamageData.x);
    r5.w = r9.x ? r5.w : 0;
    r6.xyzw = r5.wwww ? r6.xyzw : float4(0,0,0,0.5);
    r5.w = r6.w * 2 + -1;
    r5.w = 1 + -abs(r5.w);
    r6.w = 1 + -r8.x;
    r9.x = r6.w * r6.w;
    r9.x = r9.x * r8.y;
    r1.w = -r1.w * specularFalloffMult + PedDamageColors[0].w;
    r3.w = r9.x * r1.w + r3.w;
    r1.z = -r1.z * specularIntensityMult + PedDamageColors[1].w;
    r3.z = r9.x * r1.z + r3.z;
    r9.xyz = r3.xxx ? r0.xyz : float3(1,1,1);
    r6.xyz = r9.xyz * r6.xyz;
    r6.xyz = r0.xyz * r5.www + r6.xyz;
    r1.z = r3.x ? 0 : r8.z;
    r9.xyz = r6.xyz * PedDamageColors[1].xyz + -r6.xyz;
    r6.xyz = r1.zzz * r9.xyz + r6.xyz;
    r9.xyz = PedDamageColors[0].xyz * r8.yyy;
    r0.xyz = r6.xyz * r8.xxx + r9.xyz;
    r1.z = cmp(PedDamageData.y != 0.000000);
    if (r1.z != 0) {
      r1.z = cmp(0.150000006 < v7.z);
      r9.yw = frac(PedDamageData.ww);
      r9.xz = float2(0.400000006,0.400000006) * r9.ww;
      r9.xyzw = r5.yyyy ? r9.xyzw : r9.wzwz;
      r1.z = cmp((int)r5.y == (int)r1.z);
      r10.xyzw = r1.zzzz ? float4(1,0,0,1) : float4(0,-1,-1,0);
      r7.xyzw = r10.xyzw * r9.xyzw + r7.xyzw;
      r9.xyzw = pedBloodTargetSampler.SampleLevel(pedBloodTargetSampler_s, r7.xy, 0).xyzw;
      r7.xyzw = pedBloodTargetSampler.SampleLevel(pedBloodTargetSampler_s, r7.zw, 0).yzxw;
      r1.z = r3.x ? 1.000000 : 0;
      r6.x = r7.w + -r8.w;
      r6.y = r9.w + -r8.w;
      r7.x = r8.y;
      r7.y = r9.x;
      r1.w = r7.x * r6.w;
      r5.yw = r7.zy * r6.ww + -r1.ww;
      r1.zw = r1.zz * r6.xy + r5.yw;
      r6.xy = PedDamageData.yy * r1.zw;
      r1.z = dot(r6.xy, r6.xy);
      r1.z = 1 + -r1.z;
      r1.z = max(0, r1.z);
      r5.yw = cmp(v7.zw < float2(0,0));
      r7.xy = r5.ww ? r6.yx : r6.xy;
      r6.z = -r6.x;
      r5.yw = r5.yy ? r6.yz : r7.xy;
      r6.xyz = v6.xyz * r5.www;
      r6.xyz = r5.yyy * v5.xyz + r6.xyz;
      r6.xyz = r1.zzz * r4.xyz + r6.xyz;
      r1.z = dot(r6.xyz, r6.xyz);
      r1.z = rsqrt(r1.z);
      r4.xyz = r6.xyz * r1.zzz;
    }
  } else {
    r8.x = 1;
  }
  r1.z = cmp(StubbleGrowth.y != 0.000000);
  if (r1.z != 0) {
    r1.z = r8.x * r2.w;
    r1.w = cmp(_matMaterialColorScale[1].x == 1.000000);
    if (r1.w != 0) {
      r2.xy = detailSettings.zz * v1.xy;
      r6.xyzw = VolumeSampler.Sample(VolumeSampler_s, r2.xyz).yzxw;
      r6.xy = r6.xy * float2(2,2) + float2(-1,-1);
    } else {
      r2.xy = detailSettings.zz * v1.xy;
      r7.xyzw = VolumeSampler.Sample(VolumeSampler_s, r2.xyz).xyzw;
      r1.w = r3.x ? 2 : 3;
      r2.xy = v1.xy * r1.ww;
      r2.xyzw = VolumeSampler.Sample(VolumeSampler_s, r2.xyz).xyzw;
      r2.xyz = r2.yzx * float3(2,2,1) + float3(-1,-1,0);
      r7.xyz = r7.yzx * float3(2,2,1) + float3(-1,-1,0);
      r7.xyz = r7.xyz + -r2.xyz;
      r6.xyz = _matMaterialColorScale[1].xxx * r7.xyz + r2.xyz;
    }
    r2.xyzw = r3.xxxx ? float4(2,-2,2,-2) : float4(1,-1,1.5,-1.5);
    r5.yw = detailSettings.xy + r2.yw;
    r2.zw = _matMaterialColorScale[1].xx * r5.yw + r2.xz;
    r1.w = StubbleGrowth.y + r2.y;
    r1.w = _matMaterialColorScale[1].x * r1.w + r2.x;
    r2.x = r6.z * 2 + -1;
    r2.x = r2.x * r2.z;
    r2.x = r2.x * r1.z;
    r2.x = r2.x * r1.w + 1;
    r0.xyz = r2.xxx * r0.xyz;
    r2.xyz = v6.xyz * r6.yyy;
    r2.xyz = v5.xyz * r6.xxx + r2.xyz;
    r2.xyz = r2.xyz * r2.www;
    r2.xyz = r2.xyz * r1.zzz;
    r2.xyz = r2.xyz * r1.www + r4.xyz;
    r1.z = dot(r2.xyz, r2.xyz);
    r1.z = rsqrt(r1.z);
    r4.xyz = r2.xyz * r1.zzz;
  }
  r1.zw = float2(0,-0.75) + v1.zz;
  r1.zw = saturate(float2(4,4) * r1.zw);
  r2.x = cmp((int)r3.x == 0);
  r2.yzw = wetnessAdjust.xxx * r0.xyz;
  r2.yzw = r2.yzw * r1.zzz;
  r2.xyz = r2.xxx ? r2.yzw : 0;
  r0.xyz = -r2.xyz + r0.xyz;
  r1.zw = wetnessAdjust.yz * r1.ww + r3.wz;
  r0.xyz = _matMaterialColorScale[0].xxx * r0.xyz;
  r2.x = r3.x ? 0.010000 : 0;
  r2.y = r3.x ? -0.00999999978 : -0;
  r1.w = r2.y + r1.w;
  r1.w = _matMaterialColorScale[0].z * r1.w + r2.x;
  r2.x = dot(v4.xyz, v4.xyz);
  r2.x = rsqrt(r2.x);
  r2.yzw = v4.xyz * r2.xxx;
  r3.x = dot(r4.xyz, r4.xyz);
  r3.x = rsqrt(r3.x);
  r3.xzw = r4.xyz * r3.xxx;
  r2.y = saturate(dot(r2.yzw, r3.xzw));
  r2.y = 0.5 + -r2.y;
  r2.y = saturate(2.5 * r2.y);
  r2.z = r2.y * -2 + 3;
  r2.y = r2.y * r2.y;
  r2.y = r2.z * r2.y;
  r2.z = 1 + r4.z;
  r2.z = saturate(r2.z * 0.5 + -0.300000012);
  r2.z = 1.42857146 * r2.z;
  r3.xzw = saturate(v8.xyz);
  r2.y = r3.x * r2.y;
  r2.y = r2.y * r2.z;
  r2.yzw = r2.yyy * r0.xyz;
  o0.xyz = r2.yzw * _matMaterialColorScale[0].yyy + r0.xyz;
  r0.xyz = v4.xyz * r2.xxx + -r4.xyz;
  r0.xyz = r3.zzz * r0.xyz + r4.xyz;
  r2.x = 1 + -r8.x;
  r2.y = PedDamageColors[2].y + -r3.w;
  r2.x = r2.x * r2.y + r3.w;
  r2.y = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r4.y = r4.w * r2.y;
  r0.w = globalScalars.x * r0.w;
  r0.xyz = r0.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r2.yzw = float3(256,256,256) * r0.xyz;
  r2.yzw = floor(r2.yzw);
  r0.xyz = r0.xyz * float3(256,256,256) + -r2.yzw;
  r0.xyz = float3(8,8,4) * r0.xyz;
  r0.xyz = floor(r0.xyz);
  r0.x = dot(r0.yxz, float3(4,32,1));
  o1.w = 0.00392156886 * r0.x;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r2.yzw;
  r0.x = 0.001953125 * r1.z;
  r4.x = r5.z * r5.x + gLightArtificialIntAmbient0.w;
  r0.yz = float2(0.5,0.5) * r4.xy;
  o3.xy = sqrt(r0.yz);
  r0.y = 1.0196079 + r2.x;
  r0.y = r3.y ? r2.x : r0.y;
  o3.w = 0.496078432 * r0.y;
  o2.x = sqrt(r1.w);
  o2.y = sqrt(r0.x);
  r0.x = r1.x * r0.w;
  r0.x = alphaToCoverageScale * r0.x;
  o0.w = r1.y ? r0.x : r0.w;
  o2.z = specularFresnel;
  o2.w = 1;
  o3.z = 0;
  return;
}