
[Forma]
Clave=WMSFiltroLoteMovimiento
Icono=0
Modulos=(Todos)
Nombre=Filtro Herramienta Procesar en Lote (a nivel detalle)

ListaCarpetas=RepParam
CarpetaPrincipal=RepParam
PosicionInicialAlturaCliente=118
PosicionInicialAncho=338
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=173
PosicionInicialArriba=341
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaExclusiva=S
ExpresionesAlCerrar=Forma.ActualizarForma<BR>EjecutarSQL(<T>EXEC spWMSPreparaLoteMovimiento :nEstacion, :tEmpresa<T>, EstacionTrabajo, Empresa )<BR>ActualizarVista
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
FichaNombres=Arriba
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
























[Acciones.Aceptar.WMSLoteMovimiento]
Nombre=WMSLoteMovimiento
Boton=0
TipoAccion=Formas
ClaveAccion=WMSLoteMovimiento
Activo=S
Visible=S




[RepParam.RepParam.InfoZona]
Carpeta=RepParam
Clave=RepParam.InfoZona
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

Pegado=N
[RepParam.RepParam.InfoArticuloEsp]
Carpeta=RepParam
Clave=RepParam.InfoArticuloEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco





[RepParam.RepParam.InfoFila]
Carpeta=RepParam
Clave=RepParam.InfoFila
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

Pegado=N
[RepParam.RepParam.InfoNivelWMS]
Carpeta=RepParam
Clave=RepParam.InfoNivelWMS
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

Pegado=N
[RepParam.RepParam.InfoPasillo]
Carpeta=RepParam
Clave=RepParam.InfoPasillo
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco







Pegado=N
LineaNueva=S
[Lista.Columnas]
Articulo=131
Descripcion1=244


[Acciones.Aceptar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Cerrar
Cerrar=WMSLoteMovimiento
WMSLoteMovimiento=Actualizar Vista
Actualizar Vista=(Fin)





























[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoArticuloEsp
RepParam.InfoArticuloEsp=RepParam.InfoZona
RepParam.InfoZona=RepParam.InfoPasillo
RepParam.InfoPasillo=RepParam.InfoFila
RepParam.InfoFila=RepParam.InfoNivelWMS
RepParam.InfoNivelWMS=(Fin)
