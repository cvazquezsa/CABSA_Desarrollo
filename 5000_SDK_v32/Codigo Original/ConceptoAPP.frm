
[Forma]
Clave=ConceptoAPP
Icono=86
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=Concepto


ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=438
PosicionInicialArriba=241
PosicionInicialAlturaCliente=273
PosicionInicialAncho=591
Comentarios=Info.Modulo
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConceptoAPP
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

CarpetaVisible=S

Filtros=S
PermiteEditar=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ConceptoAPP.Modulo = <T>{Info.Modulo}<T>
[Lista.ConceptoAPP.Concepto]
Carpeta=Lista
Clave=ConceptoAPP.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ConceptoAPP.ConceptoAPP]
Carpeta=Lista
Clave=ConceptoAPP.ConceptoAPP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Concepto=300
ConceptoAPP=216






[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



GuardarAntes=S


[Lista.ListaEnCaptura]
(Inicio)=ConceptoAPP.ConceptoAPP
ConceptoAPP.ConceptoAPP=ConceptoAPP.Concepto
ConceptoAPP.Concepto=(Fin)
