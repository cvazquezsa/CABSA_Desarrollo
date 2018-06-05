
[Forma]
Clave=eDocD
Icono=0
Modulos=(Todos)
Nombre=eDoc - Lista Secciones

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Modulo,Info.Descripcion)
PosicionInicialAlturaCliente=360
PosicionInicialAncho=794
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=243
PosicionInicialArriba=163
ExpresionesAlMostrar=Asigna(Temp.Numerico4,0)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocD
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S

ListaOrden=eDocD.Orden<TAB>(Acendente)

FiltroGeneral=eDocD.Modulo = {Comillas(Info.Modulo)} AND eDocD.eDoc = {Comillas(Info.Descripcion)}
[Lista.eDocD.Seccion]
Carpeta=Lista
Clave=eDocD.Seccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.eDocD.SubSeccionDe]
Carpeta=Lista
Clave=eDocD.SubSeccionDe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.eDocD.Vista]
Carpeta=Lista
Clave=eDocD.Vista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.eDocD.Cierre]
Carpeta=Lista
Clave=eDocD.Cierre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.eDocD.TablaSt]
Carpeta=Lista
Clave=eDocD.TablaSt
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

[Lista.Columnas]
Orden=64
Seccion=154
SubSeccionDe=159
Vista=179
Cierre=87
TablaSt=179

[Acciones.MapeoCampo]
Nombre=MapeoCampo
Boton=47
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocDMapeoCampo
Activo=S
Visible=S



Antes=S












AntesExpresiones=Asigna(Info.Vista,eDocD:eDocD.Vista)<BR>Asigna(Info.RID,eDocD:eDocD.RID)<BR>Asigna(Info.Categoria,eDocD:eDocD.Seccion)





[Acciones.TagConservar]
Nombre=TagConservar
Boton=78
NombreDesplegar=&Atributos XML a conservar (vacios)
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=eDocDTagSostener
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.RID,eDocD:eDocD.RID)





























[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S







Antes=S





DespuesGuardar=S
AntesExpresiones=FormaModal(<T>eDocDOrden<T>)
[Orden.Columnas]
0=-2
1=538











[Lista.ListaEnCaptura]
(Inicio)=eDocD.Seccion
eDocD.Seccion=eDocD.SubSeccionDe
eDocD.SubSeccionDe=eDocD.Vista
eDocD.Vista=eDocD.Cierre
eDocD.Cierre=eDocD.TablaSt
eDocD.TablaSt=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=MapeoCampo
MapeoCampo=TagConservar
TagConservar=Ordenar
Ordenar=(Fin)
