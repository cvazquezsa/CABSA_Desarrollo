[Forma]
Clave=AspelTipoPolizas
Nombre=Configuración Polizas
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
ListaAcciones=Aceptar
CarpetaPrincipal=Lista
PosicionInicialIzquierda=393
PosicionInicialArriba=140
PosicionInicialAlturaCliente=273
PosicionInicialAncho=487

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AspelTipoPolizas
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
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
PestanaOtroNombre=S
PestanaNombre=Tipo Polizas
FiltroGeneral=AspelTipoPolizas.Campo = <T>TipoPoliza<T>

[Lista.AspelTipoPolizas.Valor]
Carpeta=Lista
Clave=AspelTipoPolizas.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AspelTipoPolizas.TipoPoliza]
Carpeta=Lista
Clave=AspelTipoPolizas.TipoPoliza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Rojo
Efectos=[Negritas]

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Lista.Columnas]
Valor=304
TipoPoliza=124

[Lista.ListaEnCaptura]
(Inicio)=AspelTipoPolizas.Valor
AspelTipoPolizas.Valor=AspelTipoPolizas.TipoPoliza
AspelTipoPolizas.TipoPoliza=(Fin)
