// ---- FNV Hash b04998658dc408f5

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
SamplerState pedTattooTargetSampler_s : register(s6);
SamplerState pedBloodTargetSampler_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture3D<float4> VolumeSampler : register(t2);
Texture2D<float4> pedTattooTargetSampler : register(t6);
Texture2D<float4> pedBloodTargetSampler : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD7,
  float4 pos : POSITION0,
  uint v5 : SV_IsFrontFace0,
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
  float4 r0,r1,r2,r3,r4,r5,r6;
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
  r1.z = dot(v2.xyz, v2.xyz);
  r1.z = rsqrt(r1.z);
  r2.xyz = v2.xyz * r1.zzz;
  r0.w = v3.w * r0.w;
  r1.z = PedDamageData.x * v4.z;
  r1.z = cmp(r1.z != 0.000000);
  if (r1.z != 0) {
    r3.xz = frac(v4.yx);
    r3.w = r3.x * abs(v4.z) + abs(v4.w);
    r3.x = r3.x * v1.w + v2.w;
    r1.z = frac(PedDamageData.z);
    r1.z = cmp(0.100000001 < r1.z);
    r3.y = 1 + -r3.z;
    r1.zw = r1.zz ? r3.wy : r3.zw;
    r2.w = cmp(PedDamageData.z >= 1);
    r3.xy = r2.ww ? r3.xy : r3.zx;
    r3.xyzw = pedTattooTargetSampler.SampleLevel(pedTattooTargetSampler_s, r3.xy, 0).xyzw;
    r4.xyzw = pedBloodTargetSampler.SampleLevel(pedBloodTargetSampler_s, r1.zw, 0).zxyw;
    r1.z = cmp(0.501960814 >= r3.w);
    r1.w = cmp(0 < PedDamageData.x);
    r1.z = r1.z ? r1.w : 0;
    r3.xyzw = r1.zzzz ? r3.xyzw : float4(0,0,0,0.5);
    r1.z = r3.w * 2 + -1;
    r1.z = 1 + -abs(r1.z);
    r3.xyz = r0.xyz * r1.zzz + r3.xyz;
    r5.xyz = r3.xyz * PedDamageColors[1].xyz + -r3.xyz;
    r3.xyz = r4.zzz * r5.xyz + r3.xyz;
    r4.yzw = PedDamageColors[0].xyz * r4.yyy;
    r0.xyz = r3.xyz * r4.xxx + r4.yzw;
  } else {
    r4.x = 1;
  }
  r1.z = cmp(StubbleGrowth.y != 0.000000);
  if (r1.z != 0) {
    r1.z = cmp(_matMaterialColorScale[1].x == 1.000000);
    if (r1.z != 0) {
      r3.xy = detailSettings.zz * v1.xy;
      r3.z = 0;
      r3.xyzw = VolumeSampler.Sample(VolumeSampler_s, r3.xyz).xyzw;
    } else {
      r5.xy = detailSettings.zz * v1.xy;
      r5.z = 0;
      r5.xyzw = VolumeSampler.Sample(VolumeSampler_s, r5.xyz).xyzw;
      r6.xy = float2(2,2) * v1.xy;
      r6.z = 0;
      r6.xyzw = VolumeSampler.Sample(VolumeSampler_s, r6.xyz).xyzw;
      r1.z = -r6.x + r5.x;
      r3.x = _matMaterialColorScale[1].x * r1.z + r6.x;
    }
    r1.z = -2 + detailSettings.x;
    r1.z = _matMaterialColorScale[1].x * r1.z + 2;
    r1.w = -2 + StubbleGrowth.y;
    r1.w = _matMaterialColorScale[1].x * r1.w + 2;
    r2.w = r3.x * 2 + -1;
    r1.z = r2.w * r1.z;
    r1.z = r1.z * r4.x;
    r1.z = r1.z * r1.w + 1;
    r0.xyz = r1.zzz * r0.xyz;
  }
  r1.z = saturate(4 * v1.z);
  r3.xyz = wetnessAdjust.xxx * r0.xyz;
  r0.xyz = -r3.xyz * r1.zzz + r0.xyz;
  o0.xyz = _matMaterialColorScale[0].xxx * r0.xyz;
  r0.x = globalScalars.x * r0.w;
  o1.xyz = r2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.y = r1.x * r0.x;
  r0.y = alphaToCoverageScale * r0.y;
  o0.w = r1.y ? r0.y : r0.x;
  o1.w = r0.x;
  o2.xyz = float3(0,0,0.980000019);
  o2.w = r0.x;
  o3.xyzw = float4(0,0,0,0);
  return;
}