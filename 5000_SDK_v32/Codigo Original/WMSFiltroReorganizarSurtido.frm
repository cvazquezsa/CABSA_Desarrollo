
[Forma]
Clave=WMSFiltroReorganizarSurtido
Icono=0
Modulos=(Todos)
Nombre=Filtro Reorganiza Surtido

ListaCarpetas=RepParam
CarpetaPrincipal=RepParam
PosicionInicialAlturaCliente=200
PosicionInicialAncho=521
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=131
PosicionInicialArriba=320
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
ExpresionesAlCerrar=Forma.ActualizarForma
[RepParam]
Estilo=Ficha
Clave=RepParam
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)


PestanaOtroNombre=S
FiltroGeneral=RepParam.Estacion={EstacionTrabajo}
[RepParam.RepParam.InfoFechaEmision]
Carpeta=RepParam
Clave=RepParam.InfoFechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[RepParam.RepParam.InfoFechaRequerida]
Carpeta=RepParam
Clave=RepParam.InfoFechaRequerida
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[RepParam.RepParam.InfoContacto]
Carpeta=RepParam
Clave=RepParam.InfoContacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoContactoCat]
Carpeta=RepParam
Clave=RepParam.InfoContactoCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoContactoGrupo]
Carpeta=RepParam
Clave=RepParam.InfoContactoGrupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoContactoFam]
Carpeta=RepParam
Clave=RepParam.InfoContactoFam
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoContactoRuta]
Carpeta=RepParam
Clave=RepParam.InfoContactoRuta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoContactoEstado]
Carpeta=RepParam
Clave=RepParam.InfoContactoEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoContactoZona]
Carpeta=RepParam
Clave=RepParam.InfoContactoZona
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoContactoPais]
Carpeta=RepParam
Clave=RepParam.InfoContactoPais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoContactoCP]
Carpeta=RepParam
Clave=RepParam.InfoContactoCP
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Colonia, RepParam:RepParam.InfoContacto)
[Acciones.1.aceptar]
Nombre=aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.1.hasp]
Nombre=hasp
Boton=0
TipoAccion=Formas
ClaveAccion=HeSurtidoWMS
Activo=S
Visible=S


[Acciones.1.ListaAccionesMultiples]
(Inicio)=aceptar
aceptar=hasp
hasp=(Fin)








[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=1
1=(Fin)
























[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoContacto
RepParam.InfoContacto=RepParam.InfoContactoEspecifico
RepParam.InfoContactoEspecifico=RepParam.InfoFechaEmision
RepParam.InfoFechaEmision=RepParam.InfoFechaRequerida
RepParam.InfoFechaRequerida=RepParam.InfoContactoCat
RepParam.InfoContactoCat=RepParam.InfoContactoGrupo
RepParam.InfoContactoGrupo=RepParam.InfoContactoFam
RepParam.InfoContactoFam=RepParam.InfoContactoRuta
RepParam.InfoContactoRuta=RepParam.InfoContactoEstado
RepParam.InfoContactoEstado=RepParam.InfoContactoZona
RepParam.InfoContactoZona=RepParam.InfoContactoPais
RepParam.InfoContactoPais=RepParam.InfoContactoCP
RepParam.InfoContactoCP=(Fin)

[RepParam.RepParam.InfoContactoEspecifico]
Carpeta=RepParam
Clave=RepParam.InfoContactoEspecifico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Cliente=117
Nombre=229
RFC=107
0=116
1=266
Almacen=90
Grupo=100
Sucursal=46

[Acciones.Aceptar.HeReorganizaSurtido]
Nombre=HeReorganizaSurtido
Boton=0
TipoAccion=Formas
ClaveAccion=HeReorganizaSurtido
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Cerrar
Cerrar=HeReorganizaSurtido
HeReorganizaSurtido=(Fin)
