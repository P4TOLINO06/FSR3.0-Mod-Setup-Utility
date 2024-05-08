// ---- FNV Hash 55c708e41e919661

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

cbuffer terrain_cb_common_locals : register(b12)
{
  float specularFalloffMult : packoffset(c0);
  float specularFalloffMultSpecMap : packoffset(c0.y);
  float specFalloffAdjust : packoffset(c0.z);
  float specularIntensityMult : packoffset(c0.w);
  float specularIntensityMultSpecMap : packoffset(c1);
  float specIntensityAdjust : packoffset(c1.y);
  float bumpiness : packoffset(c1.z);
  float parallaxSelfShadowAmount : packoffset(c1.w);
  float heightScale0 : packoffset(c2);
  float heightBias0 : packoffset(c2.y);
  float heightScale1 : packoffset(c2.z);
  float heightBias1 : packoffset(c2.w);
  float heightScale2 : packoffset(c3);
  float heightBias2 : packoffset(c3.y);
  float heightScale3 : packoffset(c3.z);
  float heightBias3 : packoffset(c3.w);
  float bumpSelfShadowAmount : packoffset(c4);
  float4 materialWetnessMultiplier : packoffset(c5);
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

SamplerState TextureSampler_layer0_s : register(s2);
SamplerState BumpSampler_layer0_s : register(s3);
SamplerState heightMapSamplerLayer0_s : register(s4);
SamplerState TextureSampler_layer1_s : register(s5);
SamplerState BumpSampler_layer1_s : register(s6);
SamplerState heightMapSamplerLayer1_s : register(s7);
SamplerState TextureSampler_layer2_s : register(s8);
SamplerState BumpSampler_layer2_s : register(s9);
SamplerState heightMapSamplerLayer2_s : register(s10);
SamplerState TextureSampler_layer3_s : register(s11);
SamplerState BumpSampler_layer3_s : register(s12);
SamplerState heightMapSamplerLayer3_s : register(s13);
SamplerState lookupSampler_s : register(s14);
Texture2D<float4> TextureSampler_layer0 : register(t2);
Texture2D<float4> BumpSampler_layer0 : register(t3);
Texture2D<float4> heightMapSamplerLayer0 : register(t4);
Texture2D<float4> TextureSampler_layer1 : register(t5);
Texture2D<float4> BumpSampler_layer1 : register(t6);
Texture2D<float4> heightMapSamplerLayer1 : register(t7);
Texture2D<float4> TextureSampler_layer2 : register(t8);
Texture2D<float4> BumpSampler_layer2 : register(t9);
Texture2D<float4> heightMapSamplerLayer2 : register(t10);
Texture2D<float4> TextureSampler_layer3 : register(t11);
Texture2D<float4> BumpSampler_layer3 : register(t12);
Texture2D<float4> heightMapSamplerLayer3 : register(t13);
Texture2D<float4> lookupSampler : register(t14);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float4 v6 : TEXCOORD5,
  float3 v7 : TEXCOORD6,
  float2 v8 : BLENDWEIGHT0,
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
                              { 0.800000, 0, 0, 0},
                              { 0.500000, 0, 0, 0},
                              { 0.100000, 0, 0, 0},
                              { 0, 0, 0, 0} };
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = lookupSampler.Sample(lookupSampler_s, v1.zw).xyzw;
  r1.xyz = v2.xyz + -r0.xyz;
  r0.xyz = v2.www * r1.xyz + r0.xyz;
  r0.w = dot(v7.xyz, v7.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = v7.xyz * r0.www;
  r0.w = dot(v3.xyz, v3.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = v3.xyz * r0.www;
  r0.w = dot(r1.xyz, r2.xyz);
  r1.x = saturate(0.0500000007 * v5.w);
  r1.y = abs(r0.w) * -24 + 27;
  r1.z = cmp(r1.x != 1.000000);
  if (r1.z != 0) {
    r1.z = 5 * r1.x;
    r1.w = (int)r1.z;
    r1.w = min(4, (int)r1.w);
    r2.x = (int)r1.w + 1;
    r2.x = min(4, (int)r2.x);
    r1.z = trunc(r1.z);
    r1.z = r1.x * 5 + -r1.z;
    r2.x = icb[r2.x+0].x + -icb[r1.w+0].x;
    r1.z = r1.z * r2.x + icb[r1.w+0].x;
  } else {
    r1.z = 0;
  }
  r1.w = r1.y * r1.z;
  r2.x = (int)r1.w;
  r2.y = cmp(0 >= (int)r2.x);
  r2.w = cmp(POMFlags.x == 1.000000);
  r2.y = (int)r2.w | (int)r2.y;
  if (r2.y == 0) {
    r2.y = saturate(v8.x);
    r2.w = -13 + v5.w;
    r2.w = saturate(0.142857149 * r2.w);
    r2.yw = float2(1,1) + -r2.yw;
    r2.y = r2.y * r2.w;
    r1.y = saturate(r1.y * r1.z + -1);
    r0.w = 4 * abs(r0.w);
    r0.w = min(1, r0.w);
    r0.w = r1.y * r0.w;
    r0.w = r2.y * r0.w;
    r0.w = globalHeightScale * r0.w;
    r1.y = cmp(0 < r0.w);
    if (r1.y != 0) {
      r3.xyz = float3(1,1,1) + -r0.xyz;
      r1.y = r3.x * r3.y;
      r1.z = r1.y * r3.z;
      r1.y = r1.y * r0.z;
      r2.y = r3.x * r0.y;
      r2.w = r2.y * r3.z;
      r2.y = r2.y * r0.z;
      r3.xy = heightScale1 * r1.yy;
      r3.xy = heightScale0 * r1.zz + r3.xy;
      r3.xy = heightScale2 * r2.ww + r3.xy;
      r3.xy = heightScale3 * r2.yy + r3.xy;
      r3.x = r3.x * r0.w;
      r3.z = cmp(r3.x != 0.000000);
      if (r3.z != 0) {
        r4.x = dot(v5.xyz, v7.xyz);
        r4.y = dot(v6.xyz, v7.xyz);
        r4.z = dot(v3.xyz, v7.xyz);
        r3.z = max(0.100000001, v8.y);
        r3.z = min(1, r3.z);
        r3.z = 1 + -r3.z;
        r5.x = dot(v5.xyz, gDirectionalLight.xyz);
        r5.y = dot(v6.xyz, gDirectionalLight.xyz);
        r5.z = dot(v3.xyz, gDirectionalLight.xyz);
        r3.w = dot(r5.xyz, r5.xyz);
        r3.w = rsqrt(r3.w);
        r5.xyz = r5.xyz * r3.www;
        r3.w = dot(v3.xyz, r5.xyz);
        r3.w = cmp(0 < r3.w);
        r1.w = trunc(r1.w);
        r1.w = 1 / r1.w;
        r4.w = dot(r4.xyz, r4.xyz);
        r4.w = rsqrt(r4.w);
        r4.xyz = r4.xyz * r4.www;
        r3.z = max(r4.z, r3.z);
        r4.zw = -r4.xy / r3.zz;
        r4.zw = r4.zw * r3.xx;
        r4.xy = r4.xy / r3.zz;
        r3.yz = r4.xy * r3.yy;
        r3.yz = r3.yz * r0.ww;
        r6.xyzw = heightMapSamplerLayer0.SampleLevel(heightMapSamplerLayer0_s, v1.xy, 0).xyzw;
        r7.xyzw = heightMapSamplerLayer1.SampleLevel(heightMapSamplerLayer1_s, v1.xy, 0).xyzw;
        r0.w = r7.x * r1.y;
        r0.w = r6.x * r1.z + r0.w;
        r6.xyzw = heightMapSamplerLayer2.SampleLevel(heightMapSamplerLayer2_s, v1.xy, 0).xyzw;
        r0.w = r6.x * r2.w + r0.w;
        r6.xyzw = heightMapSamplerLayer3.SampleLevel(heightMapSamplerLayer3_s, v1.xy, 0).xyzw;
        r0.w = r6.x * r2.y + r0.w;
        r0.w = 9.99999997e-07 + r0.w;
        r4.xy = r3.yz;
        r5.w = 1;
        r6.yz = r0.ww;
        r6.xw = float2(1,0);
        while (true) {
          r7.x = cmp((int)r6.w >= (int)r2.x);
          if (r7.x != 0) break;
          r7.x = cmp(r6.y < r5.w);
          if (r7.x != 0) {
            r7.x = r5.w + -r1.w;
            r4.xy = r4.zw * r1.ww + r4.xy;
            r7.yz = v1.xy + r4.xy;
            r8.xyzw = heightMapSamplerLayer0.SampleLevel(heightMapSamplerLayer0_s, r7.yz, 0).xyzw;
            r9.xyzw = heightMapSamplerLayer1.SampleLevel(heightMapSamplerLayer1_s, r7.yz, 0).xyzw;
            r7.w = r9.x * r1.y;
            r7.w = r8.x * r1.z + r7.w;
            r8.xyzw = heightMapSamplerLayer2.SampleLevel(heightMapSamplerLayer2_s, r7.yz, 0).xyzw;
            r7.w = r8.x * r2.w + r7.w;
            r8.xyzw = heightMapSamplerLayer3.SampleLevel(heightMapSamplerLayer3_s, r7.yz, 0).xyzw;
            r7.y = r8.x * r2.y + r7.w;
            r6.x = r5.w;
            r6.zw = r6.yw;
            r5.w = r7.x;
            r6.y = r7.y;
          } else {
            r6.w = r2.x;
          }
          r6.w = (int)r6.w + 1;
        }
        r1.w = -r6.y + r5.w;
        r2.x = r6.x + -r6.z;
        r4.x = r2.x + -r1.w;
        r4.y = cmp(r4.x != 0.000000);
        r1.w = r6.x * r1.w;
        r1.w = r5.w * r2.x + -r1.w;
        r1.w = r1.w / r4.x;
        r1.w = 1 + -r1.w;
        r1.w = r4.y ? r1.w : 0;
        r4.xy = r4.zw * r1.ww + r3.yz;
        r1.w = cmp(0 < parallaxSelfShadowAmount);
        r1.w = r1.w ? r3.w : 0;
        if (r1.w != 0) {
          r3.yz = r5.xy / r5.zz;
          r3.xy = r3.yz * r3.xx;
          r1.w = 0;
          r2.x = 0;
          while (true) {
            r3.z = cmp((int)r2.x >= 7);
            if (r3.z != 0) break;
            r3.z = (int)r2.x;
            r3.z = -r3.z * 0.142857149 + 1;
            r5.xy = r3.xy * r3.zz + v1.xy;
            r6.xyzw = heightMapSamplerLayer0.SampleLevel(heightMapSamplerLayer0_s, r5.xy, 0).xyzw;
            r7.xyzw = heightMapSamplerLayer1.SampleLevel(heightMapSamplerLayer1_s, r5.xy, 0).xyzw;
            r3.w = r7.x * r1.y;
            r3.w = r6.x * r1.z + r3.w;
            r6.xyzw = heightMapSamplerLayer2.SampleLevel(heightMapSamplerLayer2_s, r5.xy, 0).xyzw;
            r3.w = r6.x * r2.w + r3.w;
            r5.xyzw = heightMapSamplerLayer3.SampleLevel(heightMapSamplerLayer3_s, r5.xy, 0).xyzw;
            r3.w = r5.x * r2.y + r3.w;
            r3.w = r3.w + -r0.w;
            r3.z = r3.w + -r3.z;
            r2.x = (int)r2.x + 1;
            r3.w = (int)r2.x;
            r3.z = r3.z * r3.w;
            r1.w = max(r3.z, r1.w);
          }
          r0.w = min(1, r1.w);
          r4.z = -r0.w * parallaxSelfShadowAmount + 1;
        } else {
          r4.z = 1;
        }
      } else {
        r4.xyz = float3(0,0,1);
      }
      r0.w = -1;
    } else {
      r4.xyz = float3(0,0,1);
      r0.w = 0;
    }
    r1.yzw = r0.www ? r4.xyz : float3(0,0,1);
  } else {
    r1.yzw = float3(0,0,1);
  }
  r1.yz = v1.xy + r1.yz;
  r2.xyw = saturate(r0.xyz);
  r3.xyz = float3(1,1,1) + -r2.xyw;
  r0.w = r3.x * r3.y;
  r2.x = r0.w * r3.z;
  r0.w = r0.w * r2.w;
  r2.y = r3.x * r2.y;
  r3.x = r2.y * r3.z;
  r2.y = r2.y * r2.w;
  r4.xyzw = TextureSampler_layer0.Sample(TextureSampler_layer0_s, r1.yz).xyzw;
  r5.xyzw = TextureSampler_layer1.Sample(TextureSampler_layer1_s, r1.yz).xyzw;
  r3.yzw = r5.xyz * r0.www;
  r3.yzw = r4.xyz * r2.xxx + r3.yzw;
  r4.xyzw = TextureSampler_layer2.Sample(TextureSampler_layer2_s, r1.yz).xyzw;
  r3.xyz = r4.xyz * r3.xxx + r3.yzw;
  r4.xyzw = TextureSampler_layer3.Sample(TextureSampler_layer3_s, r1.yz).xyzw;
  r2.xyw = r4.xyz * r2.yyy + r3.xyz;
  r3.xyz = float3(1,1,1) + -r0.xyz;
  r0.x = r3.x * r3.y;
  r0.w = r0.x * r3.z;
  r0.y = r3.x * r0.y;
  r3.x = r0.y * r3.z;
  r0.xy = r0.xy * r0.zz;
  r4.xyzw = BumpSampler_layer0.Sample(BumpSampler_layer0_s, r1.yz).xyzw;
  r5.xyzw = BumpSampler_layer1.Sample(BumpSampler_layer1_s, r1.yz).xyzw;
  r3.yz = r5.xy * r0.xx;
  r3.yz = r4.xy * r0.ww + r3.yz;
  r4.xyzw = BumpSampler_layer2.Sample(BumpSampler_layer2_s, r1.yz).xyzw;
  r3.yz = r4.xy * r3.xx + r3.yz;
  r4.xyzw = BumpSampler_layer3.Sample(BumpSampler_layer3_s, r1.yz).xyzw;
  r3.yz = r4.xy * r0.yy + r3.yz;
  r3.yz = r3.yz * float2(2,2) + float2(-1,-1);
  r0.z = dot(r3.yz, r3.yz);
  r0.z = 1 + -r0.z;
  r0.z = sqrt(abs(r0.z));
  r3.w = max(0.00100000005, bumpiness);
  r3.yz = r3.yz * r3.ww;
  r4.xyz = v6.xyz * r3.zzz;
  r3.yzw = r3.yyy * v5.xyz + r4.xyz;
  r3.yzw = r0.zzz * v3.xyz + r3.yzw;
  r0.z = dot(r3.yzw, r3.yzw);
  r0.z = rsqrt(r0.z);
  r4.xyz = r3.yzw * r0.zzz;
  r3.y = materialWetnessMultiplier.y * r0.x;
  r3.y = materialWetnessMultiplier.x * r0.w + r3.y;
  r3.y = materialWetnessMultiplier.z * r3.x + r3.y;
  r3.y = materialWetnessMultiplier.w * r0.y + r3.y;
  r5.xyzw = heightMapSamplerLayer0.Sample(heightMapSamplerLayer0_s, r1.yz).xyzw;
  r6.xyzw = heightMapSamplerLayer1.Sample(heightMapSamplerLayer1_s, r1.yz).xyzw;
  r0.x = r6.y * r0.x;
  r0.x = r5.y * r0.w + r0.x;
  r5.xyzw = heightMapSamplerLayer2.Sample(heightMapSamplerLayer2_s, r1.yz).xyzw;
  r0.x = r5.y * r3.x + r0.x;
  r5.xyzw = heightMapSamplerLayer3.Sample(heightMapSamplerLayer3_s, r1.yz).xyzw;
  r0.x = r5.y * r0.y + r0.x;
  r0.x = r0.x * r0.x + -1;
  r0.y = specIntensityAdjust * r0.x + 1;
  r5.x = specularIntensityMultSpecMap * r0.y;
  r0.x = specFalloffAdjust * r0.x + 1;
  r0.x = specularFalloffMultSpecMap * r0.x;
  r0.y = cmp(r1.x == 1.000000);
  r0.w = dot(r2.xyw, float3(1.27499998,4.29239988,0.432599992));
  r0.w = 0.5 + -r0.w;
  r0.w = saturate(v3.w + -r0.w);
  r1.y = cmp(0.800000012 < r1.x);
  r1.x = -0.800000012 + r1.x;
  r1.x = 5 * r1.x;
  r1.z = r0.w + -r1.w;
  r1.x = r1.x * r1.z + r1.w;
  r1.x = r1.y ? r1.x : r1.w;
  o2.w = r0.y ? r0.w : r1.x;
  r0.y = saturate(r2.z * 128 + -127);
  o1.xyz = r4.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.w = -0.100000001 + r3.y;
  r0.w = saturate(10 * r0.w);
  o1.w = r0.y * r0.w;
  r5.y = 0.001953125 * r0.x;
  r0.x = gLightArtificialIntAmbient0.w + v4.x;
  r0.y = v4.y;
  r0.xy = float2(0.5,0.5) * r0.xy;
  o3.xy = sqrt(r0.xy);
  r0.x = r3.w * r0.z + -0.349999994;
  r0.x = saturate(1.53846157 * r0.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.y = 1 + -globalScalars2.z;
  r0.x = r0.x * r0.y;
  r0.x = v4.x * r0.x;
  r0.y = -r5.x * 0.5 + 1;
  r0.y = r0.x * r0.y;
  r0.z = 1 + -r3.y;
  r0.y = r0.y * r0.z;
  r0.x = r0.x * r3.y;
  r0.y = r0.y * -0.5 + 1;
  o0.xyz = r2.xyw * r0.yyy;
  r0.yz = float2(0.5,0.48828125) + -r5.xy;
  r0.yz = max(float2(0,0), r0.yz);
  r0.xy = r0.yz * r0.xx + r5.xy;
  o2.xy = sqrt(r0.xy);
  o0.w = globalScalars.x;
  o2.z = 0.980000019;
  o3.zw = float2(0,1.00188386);
  return;
}