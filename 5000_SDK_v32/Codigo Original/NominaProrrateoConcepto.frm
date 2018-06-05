
[Forma]
Clave=NominaProrrateoConcepto
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=GAS
Nombre=Concepto Gasto
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=506
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=475
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Concepto Gasto
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaProrrateoConcepto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=NominaProrrateoConcepto.ConceptoGasto<TAB>(Acendente)
CarpetaVisible=S

[Lista.NominaProrrateoConcepto.ConceptoGasto]
Carpeta=Lista
Clave=NominaProrrateoConcepto.ConceptoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Conceptos]
Nombre=Conceptos
Boton=6
NombreEnBoton=S
NombreDesplegar=&Conceptos Nomina
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=NominaProrrateoConceptoD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(NominaProrrateoConcepto:NominaProrrateoConcepto.ConceptoGasto)
Antes=S
AntesExpresiones=Asigna(Info.Concepto, NominaProrrateoConcepto:NominaProrrateoConcepto.ConceptoGasto)
DespuesGuardar=S
Visible=S


[Lista.Columnas]
ConceptoGasto=304


0=116
1=266
Proveedor=124
[Lista.ListaEnCaptura]
(Inicio)=NominaProrrateoConcepto.ConceptoGasto
NominaProrrateoConcepto.ConceptoGasto=NominaProrrateoConcepto.Proveedor
NominaProrrateoConcepto.Proveedor=(Fin)

[Lista.NominaProrrateoConcepto.Proveedor]
Carpeta=Lista
Clave=NominaProrrateoConcepto.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Conceptos
Conceptos=(Fin)
