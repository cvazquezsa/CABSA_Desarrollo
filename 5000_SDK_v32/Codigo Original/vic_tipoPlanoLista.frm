
[Forma]
Clave=vic_tipoPlanoLista
Icono=0
Modulos=(Todos)
Nombre=Tipo Plano

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
PosicionInicialIzquierda=644
PosicionInicialArriba=359
PosicionInicialAlturaCliente=314
PosicionInicialAncho=717
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Tipos de Plano
Vista=vic_tipoPlano
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombre=vic_tipoPlano:vic_TipoPlano.TipoPlano
IconosSubTitulo=<T>Tipo Plano<T>
IconosConPaginas=S
ListaEnCaptura=(Lista)
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Lista.ListaEnCaptura]
(Inicio)=vic_TipoPlano.FiltroLista
vic_TipoPlano.FiltroLista=vic_TipoPlano.TotalCamposFiltroLista
vic_TipoPlano.TotalCamposFiltroLista=vic_TipoPlano.FiltroElemento
vic_TipoPlano.FiltroElemento=vic_TipoPlano.TotalCamposFiltroElemento
vic_TipoPlano.TotalCamposFiltroElemento=(Fin)

[Lista.vic_TipoPlano.FiltroLista]
Carpeta=Lista
Clave=vic_TipoPlano.FiltroLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.vic_TipoPlano.TotalCamposFiltroLista]
Carpeta=Lista
Clave=vic_TipoPlano.TotalCamposFiltroLista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.vic_TipoPlano.FiltroElemento]
Carpeta=Lista
Clave=vic_TipoPlano.FiltroElemento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.vic_TipoPlano.TotalCamposFiltroElemento]
Carpeta=Lista
Clave=vic_TipoPlano.TotalCamposFiltroElemento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=-2
1=185
2=-2
3=-2
4=-2
