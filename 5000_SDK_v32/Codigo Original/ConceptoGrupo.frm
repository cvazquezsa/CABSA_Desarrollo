[Forma]
Clave=ConceptoGrupo
Nombre=Grupos de Conceptos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
PosicionInicialIzquierda=382
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=259

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=Si
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=ConceptoGrupo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarColumnas=Si
HojaMostrarRenglones=Si
HojaColoresPorEstatus=Si
HojaMantenerSeleccion=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
HojaConfirmarEliminar=Si
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ConceptoGrupo.Grupo
CarpetaVisible=Si

[Lista.ConceptoGrupo.Grupo]
Carpeta=Lista
Clave=ConceptoGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ConceptoGrupo:ConceptoGrupo.Grupo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
Grupo=231

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
